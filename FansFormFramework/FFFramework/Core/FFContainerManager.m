//
//  FFContainerManager.m
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerManager.h"
#import "FFFormatCheck.h"
@interface FFContainerManager ()

@property (nonatomic, strong) NSMutableDictionary *map;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSMutableDictionary *formatMap;

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

- (void)addFormatCheck:(FFFormatCheck *)formatCheck forKey:(NSString *)key {
    [self.formatMap setObject:formatCheck forKey:key];
}

- (FFFormatCheck *)formatCheckForKey:(NSString *)key {
    return self.formatMap[key];
}

- (void)removeFormatCheckForKey:(NSString *)key {
    [self.formatMap removeObjectForKey:key];
}

- (void)removeAllFormatCheck {
    [self.formatMap removeAllObjects];
}

- (BOOL)checkMust {
    return [self checkMustWithErrorComplete:nil];
}

- (BOOL)checkMustWithErrorComplete:(void(^)(__kindof FFViewManager *obj, NSString *message))errorComplete {
    __block BOOL ok = YES;
    __weak typeof(self)sself = self;
    [self.subManagers enumerateObjectsUsingBlock:^(__kindof FFViewManager * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[FFContainerManager class]]) {
            FFContainerManager *temp = (FFContainerManager *)obj;
            ok = [temp checkMustWithErrorComplete:errorComplete];
        } else {
            if (![obj checkMust]) {
                ok = NO;
                if (errorComplete) {
                    errorComplete(obj, nil);
                }
            } else {
                FFFormatCheck *formatCheck = [sself formatCheckForKey:obj.key];
                
                if (formatCheck && ![formatCheck formatCheckWithString:obj.value]) {
                    if (errorComplete) {
                        errorComplete(obj, [formatCheck messageWithTitle:obj.title]);
                    }
                    ok = NO;
                }
            }
        }
        
        if (!ok) {
            *stop = YES;
        }
    }];
    
    return ok;
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

- (NSMutableDictionary *)formatMap {
    if (!_formatMap) {
        _formatMap = [NSMutableDictionary new];
    }
    return _formatMap;
}

@end
