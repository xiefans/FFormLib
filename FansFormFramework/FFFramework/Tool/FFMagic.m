//
//  FFMagic.m
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFMagic.h"


void FansMagicWillGetValue(FFView *formView, FFViewManagerWillGetValue willGetValue) {
    [formView.manager setWillGetValue:willGetValue];
}

void FansMagicDidAction(FFView *formView, FFViewManagerBlock didAction) {
    [formView.manager setDidAction:didAction];
}

__kindof FFViewManager * FansMagicCheckMust(FFContainerManager *manager) {
    
    __block FFViewManager *target = nil;
    [manager.subManagers enumerateObjectsUsingBlock:^(__kindof FFViewManager * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[FFContainerManager class]]) {
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
