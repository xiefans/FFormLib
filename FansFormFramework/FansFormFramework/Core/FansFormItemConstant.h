//
//  FansFormItemConstant.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#ifndef FansFormItemConstant_h
#define FansFormItemConstant_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , FansFormArrangeDirection) {
    FansFormArrangeVerticalDirection, // 垂直方向排列
    FansFormArrangeHorizontalDirection //水平方向排列
};



static CGFloat const FansFormItemNormalHeight = 55.f;
static CGFloat const FansFormItemNormalWidth = 200.f;
static CGFloat const FansFormItemTitleNormalWidth = 100.f;
static CGFloat const FansFormItemHorizontalNormalGap = 10.f;


static unsigned const FansFormItemTitleNoramlColor = 0x666666;
static unsigned const FansFormItemValueNoramlColor = 0x333333;
static unsigned const FansFormItemNoEditNoramlColor = 0xF3F3F3;
static unsigned const FansFormItemLineNoramlColor = 0xEEEEEE;

#endif /* FansFormItemConstant_h */
