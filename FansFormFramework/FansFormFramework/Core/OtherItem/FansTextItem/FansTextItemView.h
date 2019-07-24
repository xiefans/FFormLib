//
//  FansTextItemView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansFormItemConstant.h"

static CGFloat const FansTextItemViewNormalHeight = 160.f;

@interface FansTextItemView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLb;
@property (nonatomic, strong, readonly) UITextView *textView;
@property (nonatomic, strong, readonly) UITextView *placeholderLb;
@property (nonatomic, strong, readonly) UIView *lineView;

- (void)checkContent:(NSString *)content;

@end

