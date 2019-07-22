//
//  FansInputItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface FansInputItem : NSObject<FansFormItemInterface>

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
