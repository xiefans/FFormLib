//
//  FansFormContainerManager.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFViewManager.h"

@class FFFormatCheck;
@interface FFContainerManager : FFViewManager


/**
 检查必填和格式
 ps : 如果容器嵌套容器的情况， 不会隔级去查找对应key 。  所以需要大家在设置格式校验的时候，用直级容器去设置校验器

 @param errorComplete 不通过的回调， 当有回调时， 返回值一定是NO
 @return 是否通过
 */
- (BOOL)checkMustWithErrorComplete:(void(^)(__kindof FFViewManager *obj, NSString *message))errorComplete;

/**
 添加一个子处理器

 @param manager 处理器
 */
- (void)addSubManager:(__kindof FFViewManager *)manager;

/**
 移除一个自处理器

 @param key 指定的key
 */
- (void)removeSubManagerForKey:(NSString *)key;

/**
 获取一个子处理器

 @param key 指定的key
 @return 处理器
 */
- (__kindof FFViewManager *)subManagerForKey:(NSString *)key;

/**
 获取所有的子处理器

 @return 处理器集合
 */
- (NSArray<__kindof FFViewManager *> *)subManagers;


/**
 是否把该容器的子 视图 参数用key打包
 */
@property (nonatomic, assign, getter=isPackage) BOOL package;

/**
 添加一个格式校验器
 ps : 如果容器嵌套容器的情况， 不会隔级去查找对应key 。  所以需要大家在设置格式校验的时候，用直级容器去设置校验器

 @param formatCheck 格式校验器
 @param key 指定的key
 */
- (void)addFormatCheck:(FFFormatCheck *)formatCheck forKey:(NSString *)key;

/**
 获取一个格式校验器

 @param key 指定的key
 @return 格式校验器
 */
- (FFFormatCheck *)formatCheckForKey:(NSString *)key;

/**
 移除一个格式校验器

 @param key 指定的key
 */
- (void)removeFormatCheckForKey:(NSString *)key;

/**
 移除所有的格式校验器
 */
- (void)removeAllFormatCheck;

@end

