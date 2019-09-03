//
//  UIColor+ffColor.h
//  FFFramework
//
//  Created by ff on 2019/7/22.
//  Copyright © 2019 glority-ff. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (FFColor)

+ (UIColor *)ff_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ff_colorWithAlphaHexString:(NSString *)hexString;

+ (UIColor *)ff_colorWithHexValue:(unsigned)hexValue;
+ (UIColor *)ff_colorWithAlphaHexValue:(unsigned)hexValue;

- (NSString *)ff_hexString;
- (NSString *)ff_hexStringWithAlpha;

- (unsigned)ff_hexValue;
- (unsigned)ff_hexValueWithAlpha;

@end

