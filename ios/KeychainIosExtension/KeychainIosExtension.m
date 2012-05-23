//
//  KeychainIosExtension.m
//  KeychainIosExtension
//
//  Created by Richard Lord on 03/05/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "FRETypeConversion.h"
#import <Security/Security.h>
#import "KeychainAccessor.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

KeychainAccessor* accessor;

DEFINE_ANE_FUNCTION( insertString )
{
    NSString* key;
    if( FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status = [accessor insertObject:value forKey:key];
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( updateString )
{
    NSString* key;
    if( FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status = [accessor updateObject:value forKey:key];
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( insertOrUpdateString )
{
    NSString* key;
    if( FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value;
    if( FREGetObjectAsString( argv[1], &value ) != FRE_OK ) return NULL;
    
    OSStatus status = [accessor insertOrUpdateObject:value forKey:key];
    
    FREObject result;
    if ( FRENewObjectFromInt32( status, &result ) == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( fetchString )
{
    NSString* key;
    if( FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    NSString* value = [accessor objectForKey:key];
    
    if( value == nil )
    {
        return NULL;
    }
    
    FREObject asValue;
    if ( FRENewObjectFromString( value, &asValue ) == FRE_OK )
    {
        return asValue;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( deleteString )
{
    NSString* key;
    if( FREGetObjectAsString( argv[0], &key ) != FRE_OK ) return NULL;
    
    OSStatus status = [accessor deleteObjectForKey:key];
    
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
        MAP_FUNCTION( insertString, NULL ),
        MAP_FUNCTION( updateString, NULL ),
        MAP_FUNCTION( insertOrUpdateString, NULL ),
        MAP_FUNCTION( fetchString, NULL ),
        MAP_FUNCTION( deleteString, NULL )
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
    
    accessor = [[KeychainAccessor alloc] init];
}

void KeychainExtensionFinalizer()
{
    return;
}