//
//  FFContainerView+KeyboradAdapter.m
//  FFFramework
//
//  Created by 谢帆 on 2019/7/30.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFScrollContainerItem+KeyboradAdapter.h"
#import "UIView+FFFrame.h"
@implementation FFScrollContainerItem (KeyboradAdapter)

- (void)fans_addKeyboradAdapter {
    //如果父视图是个容器，子视图就没必要作用该方法
    if (![self.superview isKindOfClass:[FFContainerView class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventOfKeyboradShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventOfKeyboradHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)fans_removeKeyboradAdapter {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)eventOfKeyboradShow:(NSNotification *)ifity {
    NSDictionary *userInfo = [ifity userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSTimeInterval time = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    CGFloat scale = FFScreenHeight - self.ff_bottom;
    
    if (scale > height || self.ff_height < height) {
        return;
    }
    
    scale = height - scale;
    self.scrollViewHeight = self.ff_height - scale;
    [UIView animateWithDuration:time animations:^{
        self.scrollView.ff_height = self.ff_height - scale;
    }];
}

- (void)eventOfKeyboradHide:(NSNotification *)ifity {
    NSDictionary *userInfo = [ifity userInfo];
    NSTimeInterval time = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    self.scrollViewHeight = 0.f;
    [UIView animateWithDuration:time animations:^{
        self.scrollView.frame = self.bounds;
    }];
}

@end
