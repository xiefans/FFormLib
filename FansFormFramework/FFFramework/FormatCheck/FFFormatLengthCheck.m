//
//  FFFormatLengthCheck.m
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFFormatLengthCheck.h"

@implementation FFFormatLengthCheck

+ (instancetype)formatCheckWithMaxLength:(NSInteger)maxLength {
    return [self formatCheckWithMinLength:FFFormatLengthCheckIgnoreLength maxLength:maxLength];
}

+ (instancetype)formatCheckWithMinLength:(NSInteger)minLength {
    return [self formatCheckWithMinLength:minLength maxLength:FFFormatLengthCheckIgnoreLength];
}

+ (instancetype)formatCheckWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength {
    return [[self alloc] initWithMinLength:minLength maxLength:maxLength];
}

- (instancetype)initWithMaxLength:(NSInteger)maxLength {
    return [self initWithMinLength:FFFormatLengthCheckIgnoreLength maxLength:maxLength];
}

- (instancetype)initWithMinLength:(NSInteger)minLength {
    return [self initWithMinLength:minLength maxLength:FFFormatLengthCheckIgnoreLength];
}

- (instancetype)initWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength {
    if (self = [super init]) {
        
        self.minLength = minLength;
        self.maxLength = maxLength;
    }
    return self;
}

- (NSString *)messageWithTitle:(NSString *)title {
    
    if (self.minLength == FFFormatLengthCheckIgnoreLength && self.maxLength == FFFormatLengthCheckIgnoreLength) {
        return nil;
    } else if (self.minLength == FFFormatLengthCheckIgnoreLength && self.maxLength != FFFormatLengthCheckIgnoreLength) {
        //有最大值
        return [NSString stringWithFormat:@"%@长度不能超过%ld", title, self.maxLength];
    } else if (self.minLength != FFFormatLengthCheckIgnoreLength && self.maxLength == FFFormatLengthCheckIgnoreLength) {
        //有最小值
        return [NSString stringWithFormat:@"%@长度不能少于%ld", title, self.minLength];
    } else {
        //同时又最小和最大值
        if (self.maxLength < self.minLength) {
            return [NSString stringWithFormat:@"【%@】规则设置错误，最小值不能大于最大值", title];
        } else {
            
            return [NSString stringWithFormat:@"%@长度要在%ld-%ld之间", title, self.minLength, self.maxLength];
        }
    }
}

- (BOOL)formatCheckWithString:(NSString *)string {
    NSInteger count = string.length;
    if (self.minLength == FFFormatLengthCheckIgnoreLength && self.maxLength == FFFormatLengthCheckIgnoreLength) {
        return YES;
    } else if (self.minLength == FFFormatLengthCheckIgnoreLength && self.maxLength != FFFormatLengthCheckIgnoreLength) {
        //有最大值
        return count <= self.maxLength;
    } else if (self.minLength != FFFormatLengthCheckIgnoreLength && self.maxLength == FFFormatLengthCheckIgnoreLength) {
        //有最小值
        return count >= self.minLength;
    } else {
        //同时又最小和最大值
        if (self.maxLength < self.minLength) {
            return NO;
        } else {
            return (count <= self.maxLength && count >= self.minLength);
        }
    }
    
}

- (void)setMinLength:(NSInteger)minLength {
    if (minLength < FFFormatLengthCheckIgnoreLength) {
        minLength = FFFormatLengthCheckIgnoreLength;
    }
    _minLength = minLength;
}

- (void)setMaxLength:(NSInteger)maxLength {
    if (maxLength < FFFormatLengthCheckIgnoreLength) {
        maxLength = FFFormatLengthCheckIgnoreLength;
    }
    _maxLength = maxLength;
}

@end
