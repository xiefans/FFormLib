//
//  FFMultipleParametersManager.m
//  FansFormFramework
//
//  Created by fans on 2019/9/3.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFMultipleParametersManager.h"

@interface FFMultipleParametersManager ()

@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation FFMultipleParametersManager
@synthesize willGetValue = _willGetValue;

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    if (parameter && key) {
        [self.parameters setObject:parameter forKey:key];
    }
}

- (void)removeParameterForKey:(NSString *)key {
    if (key) {
        [self.parameters removeObjectForKey:key];
    }
}

- (id)paramterForKey:(NSString *)key {
    return self.parameters[key];
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
        id value = self.parameters[key];
        
        value = [self excuteWillGetValue:value withKey:key];
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
    
    if (!self.must || (self.must && self.value)) {
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
