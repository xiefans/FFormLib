//
//  FansInputView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FansInputView : UIView

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, strong, readonly) UILabel *titleLb;
@property (nonatomic, strong, readonly) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
