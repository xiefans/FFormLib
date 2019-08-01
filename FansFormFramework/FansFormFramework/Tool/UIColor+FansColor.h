//
//  UIColor+FansColor.h
//  FFFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (FansColor)

+ (UIColor *)fans_colorWithHexString:(NSString *)hexString;
+ (UIColor *)fans_colorWithAlphaHexString:(NSString *)hexString;

+ (UIColor *)fans_colorWithHexValue:(unsigned)hexValue;
+ (UIColor *)fans_colorWithAlphaHexValue:(unsigned)hexValue;

- (NSString *)fans_hexString;
- (NSString *)fans_hexStringWithAlpha;

- (unsigned)fans_hexValue;
- (unsigned)fans_hexValueWithAlpha;

@end

