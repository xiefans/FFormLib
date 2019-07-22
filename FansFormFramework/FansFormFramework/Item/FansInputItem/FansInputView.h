//
//  FansInputView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FansFormProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface FansInputView : UIView<FansFormItemViewInterface>

@property (nonatomic, strong, readonly) UITextView *textView;
@property (nonatomic, strong, readonly) UILabel *titleLb;

@end

NS_ASSUME_NONNULL_END
