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
