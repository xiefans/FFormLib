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

void FFMagicInputShouldBeginEditing(__kindof FFContainerView *formView, NSString *key, FFInputViewShouldBeginEditingBlock shouldBeginEditing) {
    FFInputView *inputView = [formView ff_subviewForKey:key];
    if ([inputView isKindOfClass:[FFInputView class]]) {
        [inputView setShouldBeginEditing:shouldBeginEditing];
    }
}

void FFMagicInputDidEndEditing(__kindof FFContainerView *formView, NSString *key, FFInputViewDidEndEditingBlock didEndEditing) {
    FFInputView *inputView = [formView ff_subviewForKey:key];
    if ([inputView isKindOfClass:[FFInputView class]]) {
        [inputView setDidEndEditing:didEndEditing];
    }
}
