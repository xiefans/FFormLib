//
//  FFMultipleParametersManager.m
//  FansFormFramework
//
//  Created by fans on 2019/9/3.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFMultipleParametersManager.h"

@interface FFMultipleParametersManagerItem : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) BOOL must;
@property (nonatomic, strong) id value;

@end

@implementation FFMultipleParametersManagerItem


@end

@interface FFMultipleParametersManager ()

@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation FFMultipleParametersManager

- (void)registerKey:(NSString *)key must:(BOOL)must {
    FFMultipleParametersManagerItem *item = self.parameters[key];
    if (item == nil) {
        item = [[FFMultipleParametersManagerItem alloc] init];
        [self.parameters setObject:item forKey:key];
    }
    item.key = key;
    item.must = must;
}

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    FFMultipleParametersManagerItem *item = self.parameters[key];
    if (item) {
        item.value = parameter;
    }
}

- (void)removeParameterForKey:(NSString *)key {
    if (key) {
        [self.parameters removeObjectForKey:key];
    }
}

- (id)paramterForKey:(NSString *)key {
    FFMultipleParametersManagerItem *item = self.parameters[key];
    return item.value;
}

- (id)excuteWillGetValue:(id)value withKey:(NSString *)key {
    if (self.multipleWillGetValue) {
        return self.multipleWillGetValue(self, value, key);
    }
    return value;
}

- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (NSString *key in self.parameters.allKeys) {
        FFMultipleParametersManagerItem *item = self.parameters[key];
        
        id value = [self excuteWillGetValue:item.value withKey:key];
        if (key && value && !self.isIgnore) {
            [dict setObject:value forKey:key];
        }
    }
    
    return dict;
}

- (BOOL)checkMust {
    if (!self.isShow) {
        return YES;
    }
    
    BOOL res = YES;
    for (FFMultipleParametersManagerItem *item in self.parameters.allValues) {
        if (item.must && !item.value) {
            res = NO;
            break;
        }
    }
    
    if (!self.must || (self.must && res)) {
        return YES;
    } else {
        return NO;
    }
}

- (NSMutableDictionary *)parameters {
    if (!_parameters) {
        _parameters = [[NSMutableDictionary alloc] init];
    }
    return _parameters;
}

@end
