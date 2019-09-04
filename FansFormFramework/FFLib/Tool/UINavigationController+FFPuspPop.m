//
//  UINavigationController+FFPuspPop.m
//  EverLens
//
//  Created by fans on 2019/9/2.
//  Copyright © 2019 glority. All rights reserved.
//

#import "UINavigationController+FFPuspPop.h"
#import <objc/runtime.h>

typedef struct FFPuspPopDelegateIndicate {
    unsigned int willShowViewController : 1;
    unsigned int didShowViewController : 1;
    unsigned int navigationControllerSupportedInterfaceOrientations : 1;
    unsigned int navigationControllerPreferredInterfaceOrientationForPresentation : 1;
    unsigned int interactionControllerForAnimationController : 1;
    unsigned int animationControllerForOperation : 1;
} DelegateIndicate;

@implementation UINavigationController (FFPuspPop)

#pragma mark - Overrides
+ (void)load {
    // 获取系统的对象方法
    Method setDelegateMethod = class_getInstanceMethod(self, @selector(setDelegate:));
    
    // 获取自己定义的对象方法
    Method ff_setDelegateMethod = class_getInstanceMethod(self, @selector(ff_setDelegate:));
    
    // 方法交换
    method_exchangeImplementations(setDelegateMethod, ff_setDelegateMethod);
}

#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FFPuspPopBlock)completion {
    if (self.delegate == nil) {
        [self ff_setDelegate:self];
    }
    
    self.completion = completion;
    
    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(FFPuspPopBlock)completion {
    if (self.delegate == nil) {
        [self ff_setDelegate:self];
    }
    
    self.completion = completion;
    
    return [self popViewControllerAnimated:animated];
}

#pragma mark - Private Method
- (void)ff_setDelegate:(id<UINavigationControllerDelegate>)delegate {
    if (self.delegate != self) {
        [self ff_setDelegate:self];
    }
    
    self.originDelegate = delegate;
    
    DelegateIndicate delegateIndicate = self.delegateIndicate;
    
    delegateIndicate.willShowViewController = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)];
    delegateIndicate.didShowViewController = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)];
    delegateIndicate.navigationControllerSupportedInterfaceOrientations = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)];
    delegateIndicate.navigationControllerPreferredInterfaceOrientationForPresentation = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)];
    delegateIndicate.interactionControllerForAnimationController = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)];
    delegateIndicate.animationControllerForOperation = self.originDelegate && [self.originDelegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)];
    
    [self setDelegateIndicate:delegateIndicate];
}


#pragma mark - Protocol
#pragma mark <UINavigationControllerDelegate>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.delegateIndicate.willShowViewController) {
        [self.originDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.delegateIndicate.didShowViewController) {
        [self.originDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
    
    if (self.completion) {
        self.completion(YES);
        self.completion = nil;
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    if (self.delegateIndicate.navigationControllerSupportedInterfaceOrientations) {
        return [self.originDelegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    if (self.delegateIndicate.navigationControllerPreferredInterfaceOrientationForPresentation) {
        return [self.originDelegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationPortrait;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0) {
    if (self.delegateIndicate.interactionControllerForAnimationController) {
        return [self.originDelegate navigationController:navigationController
             interactionControllerForAnimationController:animationController];
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    if (self.delegateIndicate.animationControllerForOperation) {
        return [self.originDelegate navigationController:navigationController
                         animationControllerForOperation:operation
                                      fromViewController:fromVC
                                        toViewController:toVC];
    }
    return nil;
}

#pragma mark - Setter & Getter
- (void)setCompletion:(FFPuspPopBlock)completion {
    objc_setAssociatedObject(self, @selector(completion), completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (FFPuspPopBlock)completion {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOriginDelegate:(id<UINavigationControllerDelegate>)originDelegate {
    objc_setAssociatedObject(self, @selector(originDelegate), originDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UINavigationControllerDelegate>)originDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (DelegateIndicate)delegateIndicate {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    DelegateIndicate delegateIndicate;
    if (!value) {
        DelegateIndicate *delegateIndicateP = malloc(sizeof(DelegateIndicate));
        delegateIndicateP->willShowViewController = 0;
        delegateIndicateP->didShowViewController = 0;
        delegateIndicateP->navigationControllerSupportedInterfaceOrientations = 0;
        delegateIndicateP->navigationControllerPreferredInterfaceOrientationForPresentation = 0;
        delegateIndicateP->interactionControllerForAnimationController = 0;
        delegateIndicateP->animationControllerForOperation = 0;
        value = [NSValue valueWithBytes:delegateIndicateP objCType:@encode(DelegateIndicate *)];
        objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        delegateIndicate = *delegateIndicateP;
        free(delegateIndicateP);
    }
    [value getValue:&delegateIndicate];
    
    return delegateIndicate;
}

- (void)setDelegateIndicate:(DelegateIndicate)delegateIndicate {
    
    NSValue *value = [NSValue valueWithBytes:&delegateIndicate objCType:@encode(DelegateIndicate *)];
    objc_setAssociatedObject(self, @selector(delegateIndicate), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
