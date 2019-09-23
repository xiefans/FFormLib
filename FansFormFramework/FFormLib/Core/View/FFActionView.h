//
//  FFActionItem.h
//  FFFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"

@class FFActionView;
typedef void(^FFActionViewDidAction)(__kindof FFActionView *actionView);
@interface FFActionView : FFView

+ (instancetype)actionWithKey:(NSString *)key;
+ (instancetype)actionWithManager:(__kindof FFViewManager *)manager;
+ (instancetype)actionWithKey:(NSString *)key didAction:(FFActionViewDidAction)didAction;

+ (instancetype)formViewWithKey:(NSString *)key didAction:(FFActionViewDidAction)didAction;
- (instancetype)initWithKey:(NSString *)key didAction:(FFActionViewDidAction)didAction;

@end
