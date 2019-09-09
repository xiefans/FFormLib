//
//  FFMultipleParametersManager.h
//  FansFormFramework
//
//  Created by fans on 2019/9/3.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFViewManager.h"

/**
 *  【Feature】让一个item在生成json时可以提供多组数据（key-value）
 *  注意事项：
 *  1. 在初始化时设置的key 依旧必须设置， key还是在整个体系中的唯一标识
 *  2. 唯一标识key 不参与生成json了， 需要额外设置
 */
@class FFMultipleParametersManager;
typedef id(^FFMultipleParametersManagerWillGetValue)(FFMultipleParametersManager *manager, id value, NSString *key);

@interface FFMultipleParametersManager : FFViewManager

@property (nonatomic, copy) FFMultipleParametersManagerWillGetValue multipleWillGetValue;

/**
 注册一个key （可多次调用注册多个）
 【注意】如果调用setParameter：forKey： 给的key， 没有注册，是不会调用成功的

 @param key key
 @param must 是否必填
 */
- (void)registerKey:(NSString *)key must:(BOOL)must;

- (void)setParameter:(id)parameter forKey:(NSString *)key;
- (void)removeParameterForKey:(NSString *)key;
- (id)paramterForKey:(NSString *)key;

- (id)excuteWillGetValue:(id)value withKey:(NSString *)key;

@end
