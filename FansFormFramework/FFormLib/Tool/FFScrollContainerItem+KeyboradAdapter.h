//
//  FFContainerView+KeyboradAdapter.h
//  FFFramework
//
//  Created by 谢帆 on 2019/7/30.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFScrollContainerItem.h"

@interface FFScrollContainerItem (KeyboradAdapter)

/**
 添加键盘弹出的适配
 */
- (void)ff_addKeyboradAdapter;

/**
 移除键盘弹出的适配
 */
- (void)ff_removeKeyboradAdapter;

@end
