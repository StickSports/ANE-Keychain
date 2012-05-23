//
//  FRETypeConversion.h
//  GameCenterIosExtension
//
//  Created by Richard Lord on 25/01/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#ifndef GameCenterIosExtension_FRETypeConversion_h
#define GameCenterIosExtension_FRETypeConversion_h

#import "FlashRuntimeExtensions.h"

FREResult FREGetObjectAsString( FREObject object, NSString** value );

FREResult FRENewObjectFromString( NSString* string, FREObject* asString );

#endif
