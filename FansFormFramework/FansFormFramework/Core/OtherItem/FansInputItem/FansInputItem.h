//
//  FansInputItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"

@interface FansInputItem : FansFormAbstractItem

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

- (instancetype)changeToMust;

@end

