//
//  FansInputItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormProtocol.h"

@interface FansInputItem : NSObject<FansFormItemInterface>

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key;

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                    sizeBlock:(FansFormItemGetSizeBlock)sizeBlock;

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                    sizeBlock:(FansFormItemGetSizeBlock)sizeBlock;

- (instancetype)changeToMust;

@property (nonatomic, copy, readonly) NSString *title;

@end

