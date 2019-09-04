//
//  FFActionItem.m
//  FFFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFActionView.h"

@implementation FFActionView

+ (instancetype)formViewWithKey:(NSString *)key didAction:(FFActionViewDidAction)didAction {
    return [[self alloc] initWithKey:key didAction:didAction];
}

- (instancetype)initWithKey:(NSString *)key didAction:(FFActionViewDidAction)didAction {
    if (self = [super initWithKey:key]) {
        __weak typeof(self)weakSelf = self;
        [self.manager setDidAction:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            
            if (didAction) {
                didAction(self);
            }
        }];
    }
    return self;
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        manager.viewType = FFViewManagerViewTypeAction;
    }
    return self;
}


@end
