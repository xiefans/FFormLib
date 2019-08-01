//
//  UIView+FansFrame.h
//  FFFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FANSScreenWidth [UIScreen mainScreen].bounds.size.width
#define FANSScreenHeight [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface UIView (FansFrame)

@property (nonatomic, assign) CGPoint fans_origin;
@property (nonatomic, assign) CGSize fans_size;
@property (nonatomic, assign) CGFloat fans_x;
@property (nonatomic, assign) CGFloat fans_y;
@property (nonatomic, assign) CGFloat fans_width;
@property (nonatomic, assign) CGFloat fans_height;

@property (nonatomic, assign) CGFloat fans_centerX;
@property (nonatomic, assign) CGFloat fans_centerY;

@property (nonatomic, assign) CGFloat fans_maxX;
@property (nonatomic, assign) CGFloat fans_maxY;

@property (nonatomic, assign) CGFloat fans_left;
@property (nonatomic, assign) CGFloat fans_top;
@property (nonatomic, assign) CGFloat fans_right;
@property (nonatomic, assign) CGFloat fans_bottom;

@property (nonatomic, assign) CGFloat fans_halfWidth;
@property (nonatomic, assign) CGFloat fans_halfHeight;

/**< 水平填充父视图 */
- (void)fans_layoutFillSuperviewHorizontal;
/**< 水平填充父视图，左边距为leftMargin */
- (void)fans_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin;
/**< 水平填充父视图，右边距为rightMargin */
- (void)fans_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin;
/**< 水平填充父视图，左边距为leftMargin，右边距为rightMargin */
- (void)fans_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

/**< 竖直填充父视图 */
- (void)fans_layoutFillSuperviewVertical;
/**< 竖直填充父视图，顶部边距为topMargin */
- (void)fans_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin;
/**< 竖直填充父视图，底部边距为bottomMargin */
- (void)fans_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin;
/**< 竖直填充父视图，顶部边距为topMargin，底部边距为bottomMargin */
- (void)fans_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin;

/**< 设置布局 |(left)->(right)| */
- (void)fans_layoutLeft:(CGFloat)left right:(CGFloat)right;
/**< 设置布局 |(left)->(left + width)| */
- (void)fans_layoutLeft:(CGFloat)left width:(CGFloat)width;
/**< 设置布局 |(right - width)->(right)| */
- (void)fans_layoutRight:(CGFloat)right width:(CGFloat)width;
/**< 设置布局 |(top)->(bottom)| */
- (void)fans_layoutTop:(CGFloat)top bottom:(CGFloat)bottom;
/**< 设置布局 |(top)->(top + height)| */
- (void)fans_layoutTop:(CGFloat)top height:(CGFloat)height;
/**< 设置布局 |(bottom - height)->(bottom)| */
- (void)fans_layoutBottom:(CGFloat)bottom height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
