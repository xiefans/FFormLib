//
//  FFContainerView.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"
#import "FFContainerManager.h"

/* 默认的容器类 */
@interface FFContainerView : FFView

- (__kindof FFContainerManager *)manager;

- (void)addSubview:(__kindof FFView *)view;
- (void)removeSubviewForKey:(NSString *)key;
- (__kindof FFView *)subviewForKey:(NSString *)key;
- (NSArray<__kindof FFView *> *)subviews;


/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat scrollViewHeight;


@end
