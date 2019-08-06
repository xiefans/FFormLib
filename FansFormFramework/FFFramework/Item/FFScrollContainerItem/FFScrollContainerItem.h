//
//  FFScrollContainerItem.h
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerView.h"

typedef NS_OPTIONS(NSInteger , FFScrollContainerItemScrollPosition) {
    FFScrollContainerItemScrollPositionCenter = 0, /**< 滑动到视图中心 */
    FFScrollContainerItemScrollPositionBottom = 1 << 1, /**< 滑动到视图底部 */
    FFScrollContainerItemScrollPositionTop = 1 << 2, /**< 滑动到视图顶部 */
    FFScrollContainerItemScrollPositionLeft = 1 << 3, /**< 滑动到视图左侧 */
    FFScrollContainerItemScrollPositionRight = 1 << 4, /**< 滑动到视图右侧 */
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
