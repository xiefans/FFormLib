//
//  FFScrollContainerItem.h
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerView.h"

typedef NS_ENUM(NSInteger , FFScrollContainerItemScrollPosition) {
    FFScrollContainerItemScrollPositionBottom, /**< 滑动到视图底部 */
    FFScrollContainerItemScrollPositionCenter, /**< 滑动到视图中心 */
    FFScrollContainerItemScrollPositionTop /**< 滑动到视图顶部 */
};

@interface FFScrollContainerItem : FFContainerView

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat scrollViewHeight;

/**
 滑动一个子item 到指定的位置

 @param key item的key
 @param position 位置
 */
- (void)scrollItemForKey:(NSString *)key
              toPosition:(FFScrollContainerItemScrollPosition)position;

/**
 滑动一个子item 到指定的位置
 
 @param key item的key
 @param position 位置
 @param animation 是否带动画
 */
- (void)scrollItemForKey:(NSString *)key
              toPosition:(FFScrollContainerItemScrollPosition)position
               animation:(BOOL)animation;

@end
