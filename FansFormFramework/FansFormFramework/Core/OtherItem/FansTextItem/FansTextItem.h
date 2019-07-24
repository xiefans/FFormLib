//
//  FansTextItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"
#import "FansTextItemView.h"


@interface FansTextItem : FansFormAbstractItem

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key;

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                  configBlock:(FansFormItemBlock)configBlock;

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                  configBlock:(FansFormItemBlock)configBlock;

- (FansTextItemView *)contentView;

@end

