//
//  UIView+ffFrame.h
//  FFFramework
//
//  Created by ff on 2019/7/22.
//  Copyright © 2019 glority-ff. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FFScreenWidth [UIScreen mainScreen].bounds.size.width
#define FFScreenHeight [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface UIView (FFFrame)

@property (nonatomic, assign) CGPoint ff_origin;
@property (nonatomic, assign) CGSize ff_size;
@property (nonatomic, assign) CGFloat ff_x;
@property (nonatomic, assign) CGFloat ff_y;
@property (nonatomic, assign) CGFloat ff_width;
@property (nonatomic, assign) CGFloat ff_height;

@property (nonatomic, assign) CGFloat ff_centerX;
@property (nonatomic, assign) CGFloat ff_centerY;

@property (nonatomic, assign) CGFloat ff_maxX;
@property (nonatomic, assign) CGFloat ff_maxY;

@property (nonatomic, assign) CGFloat ff_left;
@property (nonatomic, assign) CGFloat ff_top;
@property (nonatomic, assign) CGFloat ff_right;
@property (nonatomic, assign) CGFloat ff_bottom;

@property (nonatomic, assign) CGFloat ff_halfWidth;
@property (nonatomic, assign) CGFloat ff_halfHeight;

/**< 水平填充父视图 */
- (void)ff_layoutFillSuperviewHorizontal;
/**< 水平填充父视图，左边距为leftMargin */
- (void)ff_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin;
/**< 水平填充父视图，右边距为rightMargin */
- (void)ff_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin;
/**< 水平填充父视图，左边距为leftMargin，右边距为rightMargin */
- (void)ff_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

/**< 竖直填充父视图 */
- (void)ff_layoutFillSuperviewVertical;
/**< 竖直填充父视图，顶部边距为topMargin */
- (void)ff_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin;
/**< 竖直填充父视图，底部边距为bottomMargin */
- (void)ff_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin;
/**< 竖直填充父视图，顶部边距为topMargin，底部边距为bottomMargin */
- (void)ff_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin;

/**< 设置布局 |(left)->(right)| */
- (void)ff_layoutLeft:(CGFloat)left right:(CGFloat)right;
/**< 设置布局 |(left)->(left + width)| */
- (void)ff_layoutLeft:(CGFloat)left width:(CGFloat)width;
/**< 设置布局 |(right - width)->(right)| */
- (void)ff_layoutRight:(CGFloat)right width:(CGFloat)width;
/**< 设置布局 |(top)->(bottom)| */
- (void)ff_layoutTop:(CGFloat)top bottom:(CGFloat)bottom;
/**< 设置布局 |(top)->(top + height)| */
- (void)ff_layoutTop:(CGFloat)top height:(CGFloat)height;
/**< 设置布局 |(bottom - height)->(bottom)| */
- (void)ff_layoutBottom:(CGFloat)bottom height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
