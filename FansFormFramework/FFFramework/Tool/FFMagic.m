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
