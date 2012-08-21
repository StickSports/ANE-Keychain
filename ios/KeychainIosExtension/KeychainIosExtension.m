//
//  KeychainIosExtension.m
//  KeychainIosExtension
//
//  Created by Richard Lord on 03/05/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "KeychainFRETypeConversion.h"
#import <Security/Security.h>
#import "KeychainAccessor.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

KeychainAccessor* keychainAccessor;

DEFINE_ANE_FUNCTION( insertStringInKeychain )
{
    NSString* key;
    if( keychain_FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( keychain_FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status;
    
    if( argc >= 3 )
    {
        NSString* accessGroup;
        if( keychain_FREGetObjectAsString( argv[2], &accessGroup ) != FRE_OK ) return NULL;
        status = [keychainAccessor insertObject:value forKey:key withAccessGroup:accessGroup];
    }
    else
    {
        status = [keychainAccessor insertObject:value forKey:key];
    }
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( updateStringInKeychain )
{
    NSString* key;
    if( keychain_FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( keychain_FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status;
    if( argc >= 3 )
    {
        NSString* accessGroup;
        if( keychain_FREGetObjectAsString( argv[2], &accessGroup ) != FRE_OK ) return NULL;
        status = [keychainAccessor updateObject:value forKey:key withAccessGroup:accessGroup];
    }
    else
    {
        status = [keychainAccessor updateObject:value forKey:key];
    }
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( insertOrUpdateStringInKeychain )
{
    NSString* key;
    if( keychain_FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( keychain_FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status;
    if( argc >= 3 )
    {
        NSString* accessGroup;
        if( keychain_FREGetObjectAsString( argv[2], &accessGroup ) != FRE_OK ) return NULL;
        status = [keychainAccessor insertOrUpdateObject:value forKey:key withAccessGroup:accessGroup];
    }
    else
    {
        status = [keychainAccessor insertOrUpdateObject:value forKey:key];
    }
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( fetchStringFromKeychain )
{
    NSString* key;
    if( keychain_FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( argc >= 2 )
    {
        NSString* accessGroup;
        if( keychain_FREGetObjectAsString( argv[1], &accessGroup ) != FRE_OK ) return NULL;
        value = [keychainAccessor objectForKey:key withAccessGroup:accessGroup];
    }
    else
    {
        value = [keychainAccessor objectForKey:key];
    }

    if( value == nil )
    {
        return NULL;
    }
    
    FREObject asValue;
    if ( keychain_FRENewObjectFromString( value, &asValue ) == FRE_OK )
    {
        return asValue;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( deleteStringFromKeychain )
{
    NSString* key;
    if( keychain_FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    OSStatus status;
    if( argc >= 2 )
    {
        NSString* accessGroup;
        if( keychain_FREGetObjectAsString( argv[1], &accessGroup ) != FRE_OK ) return NULL;
        status = [keychainAccessor deleteObjectForKey:key withAccessGroup:accessGroup];
    }
    else
    {
        status = [keychainAccessor deleteObjectForKey:key];
    }
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

void KeychainContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction functionMap[] =
    {
        MAP_FUNCTION( insertStringInKeychain, NULL ),
        MAP_FUNCTION( updateStringInKeychain, NULL ),
        MAP_FUNCTION( insertOrUpdateStringInKeychain, NULL ),
        MAP_FUNCTION( fetchStringFromKeychain, NULL ),
        MAP_FUNCTION( deleteStringFromKeychain, NULL )
    };
    
	*numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
	*functionsToSet = functionMap;
}

void KeychainContextFinalizer( FREContext ctx )
{
	return;
}

void KeychainExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{ 
    extDataToSet = NULL;  // This example does not use any extension data. 
    *ctxInitializerToSet = &KeychainContextInitializer;
    *ctxFinalizerToSet = &KeychainContextFinalizer;
    
    keychainAccessor = [[KeychainAccessor alloc] init];
}

void KeychainExtensionFinalizer()
{
    return;
}