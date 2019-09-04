//
//  UIView+ffFrame.m
//  FFFramework
//
//  Created by ff on 2019/7/22.
//  Copyright © 2019 glority-ff. All rights reserved.
//

#import "UIView+FFFrame.h"

@implementation UIView (FFFrame)


#pragma mark - Public Method

- (void)ff_layoutFillSuperviewHorizontal {
    [self ff_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:0.0f];
}

- (void)ff_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin {
    [self ff_layoutFillSuperviewHorizontalWithLeftMargin:leftMargin
                                             rightMargin:0.0f];
}

- (void)ff_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin {
    [self ff_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:rightMargin];
}

- (void)ff_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    self.ff_left = leftMargin;
    self.ff_width = self.superview.ff_width - (leftMargin + rightMargin);
}

- (void)ff_layoutFillSuperviewVertical {
    [self ff_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:0.0f];
}

- (void)ff_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin {
    [self ff_layoutFillSuperviewVerticalWithTopMargin:topMargin
                                         bottomMargin:0.0f];
}

- (void)ff_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin {
    [self ff_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:bottomMargin];
}

- (void)ff_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin {
    self.ff_top = topMargin;
    self.ff_height = self.superview.ff_height - (topMargin + bottomMargin);
}

- (void)ff_layoutLeft:(CGFloat)left right:(CGFloat)right {
    self.ff_left = left;
    self.ff_width = right - left;
}

- (void)ff_layoutLeft:(CGFloat)left width:(CGFloat)width {
    self.ff_left = left;
    self.ff_width = width;
}

- (void)ff_layoutRight:(CGFloat)right width:(CGFloat)width {
    self.ff_left = right - width;
    self.ff_width = width;
}

- (void)ff_layoutTop:(CGFloat)top bottom:(CGFloat)bottom {
    self.ff_top = top;
    self.ff_height = bottom - top;
}

- (void)ff_layoutTop:(CGFloat)top height:(CGFloat)height {
    self.ff_top = top;
    self.ff_height = height;
}

- (void)ff_layoutBottom:(CGFloat)bottom height:(CGFloat)height {
    self.ff_top = bottom - height;
    self.ff_height = height;
}

#pragma mark - Setter Getter

- (void)setFf_origin:(CGPoint)ff_origin {
    CGRect frame = self.frame;
    frame.origin = ff_origin;
    self.frame = frame;
}

- (CGPoint)ff_origin {
    return self.frame.origin;
}

- (void)setFf_size:(CGSize)ff_size {
    CGRect frame = self.frame;
    frame.size = ff_size;
    self.frame = frame;
}

- (CGSize)ff_size {
    return self.frame.size;
}

- (void)setFf_x:(CGFloat)ff_x {
    CGRect frame = self.frame;
    frame.origin.x = ff_x;
    self.frame = frame;
}

- (CGFloat)ff_x {
    return CGRectGetMinX(self.frame);
}

- (void)setFf_y:(CGFloat)ff_y {
    CGRect frame = self.frame;
    frame.origin.y = ff_y;
    self.frame = frame;
}

- (CGFloat)ff_y {
    return CGRectGetMinY(self.frame);
}

- (void)setFf_width:(CGFloat)ff_width {
    CGRect frame = self.frame;
    frame.size.width = ff_width;
    self.frame = frame;
}

- (CGFloat)ff_width {
    return CGRectGetWidth(self.frame);
}

- (void)setFf_height:(CGFloat)ff_height {
    CGRect frame = self.frame;
    frame.size.height = ff_height;
    self.frame = frame;
}

- (CGFloat)ff_height {
    return CGRectGetHeight(self.frame);
}

- (void)setFf_centerX:(CGFloat)ff_centerX {
    CGPoint center = self.center;
    center.x = ff_centerX;
    self.center = center;
}

- (CGFloat)ff_centerX {
    return self.center.x;
}

- (void)setFf_centerY:(CGFloat)ff_centerY {
    CGPoint center = self.center;
    center.y = ff_centerY;
    self.center = center;
}

- (CGFloat)ff_centerY {
    return self.center.y;
}

- (void)setFf_maxX:(CGFloat)ff_maxX {
    self.ff_x = ff_maxX - self.ff_width;
}

- (CGFloat)ff_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setFf_maxY:(CGFloat)ff_maxY {
    self.ff_y = ff_maxY - self.ff_height;
}

- (CGFloat)ff_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setFf_left:(CGFloat)ff_left {
    self.ff_x = ff_left;
}

- (CGFloat)ff_left {
    return self.ff_x;
}

- (void)setFf_top:(CGFloat)ff_top {
    self.ff_y = ff_top;
}

- (CGFloat)ff_top {
    return self.ff_y;
}

- (void)setFf_right:(CGFloat)ff_right {
    self.ff_maxX = ff_right;
}

- (CGFloat)ff_right {
    return self.ff_maxX;
}

- (void)setFf_bottom:(CGFloat)ff_bottom {
    self.ff_maxY = ff_bottom;
}

- (CGFloat)ff_bottom {
    return self.ff_maxY;
}

- (void)setFf_halfWidth:(CGFloat)ff_halfWidth {
    self.ff_width = ff_halfWidth * 2.0f;
}

- (CGFloat)ff_halfWidth {
    return self.ff_width / 2.0f;
}

- (void)setFf_halfHeight:(CGFloat)ff_halfHeight {
    self.ff_height = ff_halfHeight * 2.0f;
}

- (CGFloat)ff_halfHeight {
    return self.ff_height / 2.0f;
}


@end
