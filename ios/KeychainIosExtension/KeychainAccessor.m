//
//  KeychainAccessor.m
//  KeychainIosExtension
//
//  Created by Richard Lord on 03/05/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import "KeychainAccessor.h"

@implementation KeychainAccessor

-(NSMutableDictionary*)queryDictionaryForKey:(NSString*)key
{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    
    [query setObject:(id)kSecClassGenericPassword  forKey:(id)kSecClass];
    [query setObject:(id)kSecAttrAccessibleWhenUnlocked forKey:(id)kSecAttrAccessible];
    [query setObject:key forKey:(id)kSecAttrService];
    
    return query;
}

-(NSMutableDictionary*)queryDictionaryForKey:(NSString*)key accessGroup:(NSString*)accessGroup
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key];
    [query setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
    return query;
}

-(OSStatus)insertObject:(NSString*)obj forKey:(NSString*)key
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key];
    
    [query setObject:[obj dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
    
    return SecItemAdd ((CFDictionaryRef) query, NULL);
}

-(OSStatus)updateObject:(NSString*)obj forKey:(NSString*) key
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key];
    
    NSMutableDictionary* change = [NSMutableDictionary dictionary];
    [change setObject:[obj dataUsingEncoding:NSUTF8StringEncoding] forKey:(id) kSecValueData];
    
    return SecItemUpdate ( (CFDictionaryRef) query, (CFDictionaryRef) change);
}

-(OSStatus)insertOrUpdateObject:(NSString*)obj forKey:(NSString*)key
{
    OSStatus status = [self insertObject:obj forKey:key];
    if( status == errSecDuplicateItem )
    {
        status = [self updateObject:obj forKey:key];
    }
    return status;
}

-(NSString*)objectForKey:(NSString*)key
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key];
    [query setObject:(id) kCFBooleanTrue forKey:(id) kSecReturnData];
    
    NSData* data = nil;
    OSStatus status = SecItemCopyMatching ( (CFDictionaryRef) query, (CFTypeRef*) &data );
    
    if( status != errSecSuccess || !data )
    {
        return nil;
    }
    
    NSString* value = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    return value;    
}

-(OSStatus)deleteObjectForKey:(NSString*)key
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key];
    return SecItemDelete( (CFDictionaryRef) query );
}

-(OSStatus)insertObject:(NSString*)obj forKey:(NSString*)key withAccessGroup:(NSString*)accessGroup
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key accessGroup:accessGroup];
    
    [query setObject:[obj dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
    
    return SecItemAdd ((CFDictionaryRef) query, NULL);
}

-(OSStatus)updateObject:(NSString*)obj forKey:(NSString*)key withAccessGroup:(NSString*)accessGroup
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key accessGroup:accessGroup];
    
    NSMutableDictionary* change = [NSMutableDictionary dictionary];
    [change setObject:[obj dataUsingEncoding:NSUTF8StringEncoding] forKey:(id) kSecValueData];
    
    return SecItemUpdate ( (CFDictionaryRef) query, (CFDictionaryRef) change);
}

-(OSStatus)insertOrUpdateObject:(NSString*)obj forKey:(NSString*)key withAccessGroup:(NSString*)accessGroup
{
    OSStatus status = [self insertObject:obj forKey:key withAccessGroup:accessGroup];
    if( status == errSecDuplicateItem )
    {
        status = [self updateObject:obj forKey:key];
    }
    return status;
}

-(NSString*)objectForKey:(NSString*)key withAccessGroup:(NSString*)accessGroup
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key accessGroup:accessGroup];
    [query setObject:(id) kCFBooleanTrue forKey:(id) kSecReturnData];
    
    NSData* data = nil;
    OSStatus status = SecItemCopyMatching ( (CFDictionaryRef) query, (CFTypeRef*) &data );
    
    if( status != errSecSuccess || !data )
    {
        return nil;
    }
    
    NSString* value = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    return value;    
}

-(OSStatus)deleteObjectForKey:(NSString*)key withAccessGroup:(NSString*)accessGroup
{
    NSMutableDictionary* query = [self queryDictionaryForKey:key accessGroup:accessGroup];
    return SecItemDelete( (CFDictionaryRef) query );
}
@end
