//
//  UINavigationController+FFPuspPop.h
//  EverLens
//
//  Created by fans on 2019/9/2.
//  Copyright © 2019 glority. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FFPuspPopBlock)(BOOL isComplete);
@interface UINavigationController (FFPuspPop) <UINavigationControllerDelegate>

@property (nonatomic, weak) id<UINavigationControllerDelegate> originDelegate;
@property (nonatomic, copy) FFPuspPopBlock completion;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FFPuspPopBlock)completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(FFPuspPopBlock)completion;

@end
