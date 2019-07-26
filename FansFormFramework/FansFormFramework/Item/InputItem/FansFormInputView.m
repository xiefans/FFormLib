//
//  FansFormInputView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormInputView.h"

@implementation FansFormInputView

+ (instancetype)formViewWithKey:(NSString *)key must:(BOOL)must {
    FansFormInputView *view = [FansFormInputView formViewWithKey:key];
    view.must = must;
    return view;
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FansInputViewManager managerWithKey:key]];
}




@end
