//
//  ExampleViewController.h
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleModel.h"

@class FFContainerView;
@interface ExampleViewController : UIViewController

@property (nonatomic, assign) SingleModelType type;

@property (nonatomic, strong, readonly) UILabel *tipLb;

@property (nonatomic, strong, readonly) UIView *topView;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *bottomView;

- (void)eventOfShowClick;
- (void)eventOfEditClick;
- (void)eventOfMustClick;
- (void)eventOfCheckClick;

- (void)showTip:(NSString *)tip;

@end
