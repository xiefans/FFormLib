//
//  FansFormMagic.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormMagic.h"


void FansMagicWillGetValue(FansFormView *formView, FansFormViewManagerWillGetValue willGetValue) {
    [formView.manager setWillGetValue:willGetValue];
}

void FansMagicDidAction(FansFormView *formView, FansFormViewManagerBlock didAction) {
    [formView.manager setDidAction:didAction];
}

__kindof FansFormViewManager * FansMagicCheckMust(FansFormContainerManager *manager) {
    
    __block FansFormViewManager *target = nil;
    [manager.subManagers enumerateObjectsUsingBlock:^(__kindof FansFormViewManager * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[FansFormContainerManager class]]) {
            target = FansMagicCheckMust(obj);
        } else {
            if (![obj checkMust]) {
                target = obj;
            }
        }
        
        if (target) {
            *stop = YES;
        }
    }];
    
    return target;
    
}
