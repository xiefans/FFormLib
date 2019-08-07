//
//  FFContainerView.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"
#import "FFContainerManager.h"

typedef NS_ENUM(NSInteger , FFContainerViewLayoutDirection) {
    FFContainerViewLayoutDirectionVertical, /**< 垂直方向布局 */
    FFContainerViewLayoutDirectionHorizontal /**< 水平方向布局 */
};

/* 默认的容器类 */
@interface FFContainerView : FFView

+ (instancetype)formViewWithKey:(NSString *)key
                layoutDirection:(FFContainerViewLayoutDirection)layoutDirection;
- (instancetype)initWithKey:(NSString *)key
            layoutDirection:(FFContainerViewLayoutDirection)layoutDirection;
@property (nonatomic, assign, readonly) FFContainerViewLayoutDirection layoutDirection;

@property (nonatomic, strong) NSMutableDictionary *map;

- (__kindof FFContainerManager *)manager;

- (void)ff_addItem:(__kindof FFView *)view;
- (void)ff_removeItemForKey:(NSString *)key;
- (__kindof FFView *)ff_itemForKey:(NSString *)key;
- (NSArray<__kindof FFView *> *)ff_allItem;

/**
 根据key 找到这个key的直属上级 (key可以隔级查找)

 @param key key
 @return 直属容器
 */
- (__kindof FFContainerView *)ff_deepContainerForSubKey:(NSString *)key;

/**
 深度查找， 可以隔级查找到item

 @param key key
 @return item
 */
- (__kindof FFView *)ff_deepItemForKey:(NSString *)key;




@end
