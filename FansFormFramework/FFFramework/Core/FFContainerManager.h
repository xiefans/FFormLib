//
//  FansFormContainerManager.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFViewManager.h"


@interface FFContainerManager : FFViewManager

- (void)addSubManager:(__kindof FFViewManager *)manager;
- (void)removeSubManagerForKey:(NSString *)key;
- (__kindof FFViewManager *)subManagerForKey:(NSString *)key;
- (NSArray<__kindof FFViewManager *> *)subManagers;


/**
 是否把该容器的子 视图 参数用key打包
 */
@property (nonatomic, assign, getter=isPackage) BOOL package;

@end

