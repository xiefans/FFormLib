//
//  UIView+FansFrame.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "UIView+FansFrame.h"

@implementation UIView (FansFrame)


#pragma mark - Public Method

- (void)fans_layoutFillSuperviewHorizontal {
    [self fans_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:0.0f];
}

- (void)fans_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin {
    [self fans_layoutFillSuperviewHorizontalWithLeftMargin:leftMargin
                                             rightMargin:0.0f];
}

- (void)fans_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin {
    [self fans_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:rightMargin];
}

- (void)fans_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    self.fans_left = leftMargin;
    self.fans_width = self.superview.fans_width - (leftMargin + rightMargin);
}

- (void)fans_layoutFillSuperviewVertical {
    [self fans_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:0.0f];
}

- (void)fans_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin {
    [self fans_layoutFillSuperviewVerticalWithTopMargin:topMargin
                                         bottomMargin:0.0f];
}

- (void)fans_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin {
    [self fans_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:bottomMargin];
}

- (void)fans_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin {
    self.fans_top = topMargin;
    self.fans_height = self.superview.fans_height - (topMargin + bottomMargin);
}

- (void)fans_layoutLeft:(CGFloat)left right:(CGFloat)right {
    self.fans_left = left;
    self.fans_width = right - left;
}

- (void)fans_layoutLeft:(CGFloat)left width:(CGFloat)width {
    self.fans_left = left;
    self.fans_width = width;
}

- (void)fans_layoutRight:(CGFloat)right width:(CGFloat)width {
    self.fans_left = right - width;
    self.fans_width = width;
}

- (void)fans_layoutTop:(CGFloat)top bottom:(CGFloat)bottom {
    self.fans_top = top;
    self.fans_height = bottom - top;
}

- (void)fans_layoutTop:(CGFloat)top height:(CGFloat)height {
    self.fans_top = top;
    self.fans_height = height;
}

- (void)fans_layoutBottom:(CGFloat)bottom height:(CGFloat)height {
    self.fans_top = bottom - height;
    self.fans_height = height;
}

#pragma mark - Setter Getter

- (void)setFans_origin:(CGPoint)fans_origin {
    CGRect frame = self.frame;
    frame.origin = fans_origin;
    self.frame = frame;
}

- (CGPoint)fans_origin {
    return self.frame.origin;
}

- (void)setFans_size:(CGSize)fans_size {
    CGRect frame = self.frame;
    frame.size = fans_size;
    self.frame = frame;
}

- (CGSize)fans_size {
    return self.frame.size;
}

- (void)setFans_x:(CGFloat)fans_x {
    CGRect frame = self.frame;
    frame.origin.x = fans_x;
    self.frame = frame;
}

- (CGFloat)fans_x {
    return CGRectGetMinX(self.frame);
}

- (void)setFans_y:(CGFloat)fans_y {
    CGRect frame = self.frame;
    frame.origin.y = fans_y;
    self.frame = frame;
}

- (CGFloat)fans_y {
    return CGRectGetMinY(self.frame);
}

- (void)setFans_width:(CGFloat)fans_width {
    CGRect frame = self.frame;
    frame.size.width = fans_width;
    self.frame = frame;
}

- (CGFloat)fans_width {
    return CGRectGetWidth(self.frame);
}

- (void)setFans_height:(CGFloat)fans_height {
    CGRect frame = self.frame;
    frame.size.height = fans_height;
    self.frame = frame;
}

- (CGFloat)fans_height {
    return CGRectGetHeight(self.frame);
}

- (void)setFans_centerX:(CGFloat)fans_centerX {
    CGPoint center = self.center;
    center.x = fans_centerX;
    self.center = center;
}

- (CGFloat)fans_centerX {
    return self.center.x;
}

- (void)setFans_centerY:(CGFloat)fans_centerY {
    CGPoint center = self.center;
    center.y = fans_centerY;
    self.center = center;
}

- (CGFloat)fans_centerY {
    return self.center.y;
}

- (void)setFans_maxX:(CGFloat)fans_maxX {
    self.fans_x = fans_maxX - self.fans_width;
}

- (CGFloat)fans_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setFans_maxY:(CGFloat)fans_maxY {
    self.fans_y = fans_maxY - self.fans_height;
}

- (CGFloat)fans_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setFans_left:(CGFloat)fans_left {
    self.fans_x = fans_left;
}

- (CGFloat)fans_left {
    return self.fans_x;
}

- (void)setFans_top:(CGFloat)fans_top {
    self.fans_y = fans_top;
}

- (CGFloat)fans_top {
    return self.fans_y;
}

- (void)setFans_right:(CGFloat)fans_right {
    self.fans_maxX = fans_right;
}

- (CGFloat)fans_right {
    return self.fans_maxX;
}

- (void)setFans_bottom:(CGFloat)fans_bottom {
    self.fans_maxY = fans_bottom;
}

- (CGFloat)fans_bottom {
    return self.fans_maxY;
}

- (void)setFans_halfWidth:(CGFloat)fans_halfWidth {
    self.fans_width = fans_halfWidth * 2.0f;
}

- (CGFloat)fans_halfWidth {
    return self.fans_width / 2.0f;
}

- (void)setFans_halfHeight:(CGFloat)fans_halfHeight {
    self.fans_height = fans_halfHeight * 2.0f;
}

- (CGFloat)fans_halfHeight {
    return self.fans_height / 2.0f;
}


@end
