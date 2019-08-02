//
//  FFView.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFViewManager.h"
#import "FFConstant.h"

@interface FFView : UIView

+ (instancetype)formViewWithKey:(NSString *)key;
+ (instancetype)formViewWithManager:(__kindof FFViewManager *)manager;
- (instancetype)initWithKey:(NSString *)key;
- (instancetype)initWithManager:(__kindof FFViewManager *)manager;

/** 处理器 */
- (__kindof FFViewManager *)manager;

/** 整个容器体系中，唯一表示一个item */
@property (nonatomic, copy, readonly) NSString *key;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, assign, getter=isEdit) BOOL edit;
@property (nonatomic, assign, getter=isMust) BOOL must;

/* 下面三个方法是给子类重写 来改变自身的状态. 如果想手动改变一个item的状态，请使用上面三个属性 */
- (void)changeEdit:(BOOL)isEdit;
- (void)changeShow:(BOOL)isShow;
- (void)changeMust:(BOOL)isMust;

/** 刷新该view 所在容器的 布局 */
- (void)reloadLayout;

/*
 假如你需要 构建你自己的 组件库，那么请你好好的看看这段话
 如果你拓展了一个容器组件。
 1. 容器组件中的子组件，不应该考虑自己的坐标。  容器需要完全决定坐标
 2. 那么在布局子组件的时候，不需要考虑组件的paddingInsets（内边距）。应该考虑子组件的marginInsets（外边距）和容器自身的 paddingInsets。
 3. 布局时子组件的大小取size属性，不要用frame。 size 属性是子组件间接设置自身大小的途径，可以由子组件自己决定自己的高度。 容器只需要根据size布局就好了。
    size还要注意一点， 当size 的width和height都为0 时， 需要取默认值，这个可以自己定义在容器内部。也可以取全局的宽高，我定义在FFConstant.h中
 
 如果你拓展了一个普通组件。
 1. 那么在布局的时候，只需要考虑自身的内边距。
 */
@property (nonatomic, assign) UIEdgeInsets paddingInsets; /**< 内边距 */
@property (nonatomic, assign) UIEdgeInsets marginInsets; /**< 外边距 */
@property (nonatomic, assign) CGSize size; /**< 宽高，设置frame 也会改变这个值 */

@property (nonatomic, strong) UIColor *changeTempBackgroundColor; /**< 切换背景色时，暂存之前背景色的 */


@end

