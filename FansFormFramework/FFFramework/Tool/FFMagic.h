//
//  FFMagic.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFInputView.h"
#import "FFContainerView.h"
#import "FFFormatCheck.h"

/**
 便捷方式给FormView设置 willGetValue 回调

 @param formView 视图
 @param willGetValue 回调
 */
void FFMagicWillGetValue(FFView *formView, FFViewManagerWillGetValue willGetValue);

/**
 便捷方式给 formView 设置 didAction 回调

 @param formView 视图
 @param didAction 回调
 */
void FFMagicDidAction(FFView *formView, FFViewManagerBlock didAction);

/**
 便捷方式给inputView 设置 shouldBeginEditing
 
 @param formView inputView的直级容器
 @param key inputView对应的key
 @param shouldBeginEditing 回调（返回值是否可以输入）
 */
void FFMagicInputShouldBeginEditing(__kindof FFContainerView *formView, NSString *key, FFInputViewShouldBeginEditingBlock shouldBeginEditing);

/**
 便捷方式给inputView 设置 didEndEditing

 @param formView inputView的直级容器
 @param key inputView对应的key
 @param didEndEditing 结束编辑的回调
 */
void FFMagicInputDidEndEditing(__kindof FFContainerView *formView, NSString *key, FFInputViewDidEndEditingBlock didEndEditing);

/**
 给一个item，检测所有传入的FormCheck格式

 @param checkArray 需要满足格式
 @param view 待检测的item
 @param message 返回的错误提示语 (如果 返回值为NO， message为nil。  则证明待检查的value是nil)
 @return 返回是否满足
 */
BOOL FFMagicCheckFormArray(FFView *view, NSArray<FFFormatCheck *> *checkArray, NSString **message);


