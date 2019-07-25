//
//  FansFormContainerManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormContainerManager.h"

@interface FansFormContainerManager ()

@property (nonatomic, strong) NSMutableDictionary *map;
@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation FansFormContainerManager

- (void)addSubManager:(__kindof FansFormViewManager *)manager {
    [self.map setObject:manager forKey:manager.key];
    [self.list addObject:manager];
}

- (void)removeSubManagerForKey:(NSString *)key {
    FansFormViewManager *manager = [self subManagerForKey:key];
    
    [self.list removeObject:manager];
    [self.map removeObjectForKey:key];
}

- (FansFormViewManager *)subManagerForKey:(NSString *)key {
    return self.map[key];
}

- (NSArray<FansFormViewManager *> *)subManagers {
    return self.list;
}

- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [self.list enumerateObjectsUsingBlock:^(FansFormViewManager * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *temp = obj.makeDictionary;
        
        [temp enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull subObj, BOOL * _Nonnull stop) {
           
            if (key && subObj) {
                [dict setObject:subObj forKey:key];
            }
        }];
    }];
    
    if (self.isPackage) {
        return @{self.key : dict.copy};
    }
    
    return dict;
}


- (NSMutableDictionary *)map {
    if (!_map) {
        _map = [NSMutableDictionary new];
    }
    return _map;
}

- (NSMutableArray *)list {
    if (!_list){
        _list = [NSMutableArray new];
    }
    return _list;
}

@end
