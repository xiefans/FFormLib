//
//  FFScrollContainerItem.h
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerView.h"

@interface FFScrollContainerItem : FFContainerView

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat scrollViewHeight;

@end
