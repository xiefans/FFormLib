//
//  FansFormContainerManager.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormViewManager.h"


@interface FansFormContainerManager : FansFormViewManager

- (void)addSubManager:(__kindof FansFormViewManager *)manager;
- (void)removeSubManagerForKey:(NSString *)key;
- (__kindof FansFormViewManager *)subManagerForKey:(NSString *)key;
- (NSArray<__kindof FansFormViewManager *> *)subManagers;


/**
 是否把该容器的子 视图 参数用key打包
 */
@property (nonatomic, assign, getter=isPackage) BOOL package;

@end

