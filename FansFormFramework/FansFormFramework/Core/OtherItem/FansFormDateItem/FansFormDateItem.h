//
//  FansFormDateItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"
#import "FansFormDateItemView.h"

@interface FansFormDateItem : FansFormAbstractItem

+ (instancetype)itemWithTitle:(NSString *)title
                          key:(NSString *)key
             handleValueBlock:(FansFormItemHandleValueBlock)handleValueBlock;

- (FansFormDateItemView *)contentView;

- (void)setContent:(NSDate *)content;
- (void)setValue:(NSDate *)value;

@end
