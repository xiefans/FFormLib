//
//  FansFormInputView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormView.h"
#import "FansInputViewManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface FansFormInputView : FansFormView

+ (instancetype)formViewWithKey:(NSString *)key must:(BOOL)must;

@property (nonatomic, strong, readonly) UILabel *titleLb;



@end

NS_ASSUME_NONNULL_END
