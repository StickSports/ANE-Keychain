//
//  KeychainAccessor.h
//  KeychainIosExtension
//
//  Created by Richard Lord on 03/05/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//
#import <Security/Security.h>

@interface KeychainAccessor : NSObject

-(OSStatus)insertObject:(NSString*)obj forKey:(NSString*)key;
-(OSStatus)updateObject:(NSString *)obj forKey:(NSString *)key;
-(OSStatus)insertOrUpdateObject:(NSString *)obj forKey:(NSString *)key;
-(NSString *)objectForKey:(NSString *)key;
-(OSStatus)deleteObjectForKey:(NSString *)key;

@end
