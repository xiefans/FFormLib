//
//  FFInputView.m
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFInputView.h"

@implementation FFInputView

+ (instancetype)inputWithKey:(NSString *)key {
    return [self formViewWithKey:key];
}

+ (instancetype)inputWithManager:(__kindof FFViewManager *)manager {
    return [self formViewWithManager:manager];
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        manager.viewType = FFViewManagerViewTypeInput;
    }
    return self;
}

@end
