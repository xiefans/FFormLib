//
//  FansFormView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormProtocol.h"

typedef NS_ENUM(NSInteger , FansFormContainerArrangeDirection) {
    FansFormContainerArrangeVerticalDirection, // 垂直方向排列
    FansFormContainerArrangeHorizontalDirection //水平方向排列
};

NS_ASSUME_NONNULL_BEGIN

@interface FansFormView : UIView<FansFormContainerInterface, FansFormItemInterface>

+ (instancetype)formView;
+ (instancetype)formViewWithDirection:(FansFormContainerArrangeDirection)direction;

- (instancetype)initWithManager:(id<FansFormManagerInterface>)manager;
- (instancetype)initWithManager:(id<FansFormManagerInterface>)manager
                      direction:(FansFormContainerArrangeDirection)direction;

@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, assign ,readonly) FansFormContainerArrangeDirection direction;

@end

NS_ASSUME_NONNULL_END
