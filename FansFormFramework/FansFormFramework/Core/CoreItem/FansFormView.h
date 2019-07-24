//
//  FansFormView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormItemConstant.h"

@interface FansFormView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

+ (instancetype)formView;
+ (instancetype)formViewWithDirection:(FansFormArrangeDirection)direction;

- (instancetype)initWithDirection:(FansFormArrangeDirection)direction;

@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, assign ,readonly) FansFormArrangeDirection direction;


@end
