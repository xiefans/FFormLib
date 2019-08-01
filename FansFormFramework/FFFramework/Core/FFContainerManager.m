//
//  FFContainerManager.m
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerManager.h"

@interface FFContainerManager ()

@property (nonatomic, strong) NSMutableDictionary *map;
@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation FFContainerManager

- (void)addSubManager:(__kindof FFViewManager *)manager {
    [self.map setObject:manager forKey:manager.key];
    [self.list addObject:manager];
}

- (void)removeSubManagerForKey:(NSString *)key {
    FFViewManager *manager = [self subManagerForKey:key];
    
    [self.list removeObject:manager];
    [self.map removeObjectForKey:key];
}

- (FFViewManager *)subManagerForKey:(NSString *)key {
    return self.map[key];
}

- (NSArray<FFViewManager *> *)subManagers {
    return self.list;
}

- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [self.list enumerateObjectsUsingBlock:^(FFViewManager * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
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
