//
//  FFFormatLengthCheck.h
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFFormatCheck.h"

static NSInteger const FFFormatLengthCheckIgnoreLength = -100; /**< 设置该值，则不限制 */

@interface FFFormatLengthCheck : FFFormatCheck

+ (instancetype)formatCheckWithMinLength:(NSInteger)minLength
                               maxLength:(NSInteger)maxLength;

+ (instancetype)formatCheckWithMinLength:(NSInteger)minLength;
+ (instancetype)formatCheckWithMaxLength:(NSInteger)maxLength;

- (instancetype)initWithMinLength:(NSInteger)minLength
                        maxLength:(NSInteger)maxLength;
- (instancetype)initWithMinLength:(NSInteger)minLength;
- (instancetype)initWithMaxLength:(NSInteger)maxLength;

@property (nonatomic, assign) NSInteger minLength;
@property (nonatomic, assign) NSInteger maxLength;

@end
