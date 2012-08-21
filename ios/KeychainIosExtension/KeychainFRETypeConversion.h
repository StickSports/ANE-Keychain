//
//  FRETypeConversion.h
//  GameCenterIosExtension
//
//  Created by Richard Lord on 25/01/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#ifndef KeychainIosExtension_FRETypeConversion_h
#define KeychainIosExtension_FRETypeConversion_h

#import "FlashRuntimeExtensions.h"

FREResult keychain_FREGetObjectAsString( FREObject object, NSString** value );

FREResult keychain_FRENewObjectFromString( NSString* string, FREObject* asString );

#endif
