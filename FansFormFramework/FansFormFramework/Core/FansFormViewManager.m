//
//  FansFormViewManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormViewManager.h"

@implementation FansFormViewManager

+ (instancetype)managerWithKey:(NSString *)key {
    return [[self alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
    if (self = [super init]) {
        _key = key;
        _show = YES;
        _edit = YES;
    }
    return self;
}

- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    id value = [self excuteWillGetValue:_value];
    if (_key && value) {
        [dict setObject:value forKey:_key];
    }
    
    return dict;
}

- (NSString *)makeJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.makeDictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)setShow:(BOOL)show {
    if (_show != show) {
        _show = show;
        [self excuteChangeShow:show];
    }
}

- (void)setEdit:(BOOL)edit {
    if (_edit != edit) {
        _edit = edit;
        [self excuteChangeEdit:edit];
    }
}

- (void)setMust:(BOOL)must {
    if (_must != must) {
        _must = must;
        [self excuteChangeMust:must];
    }
}

- (void)excuteChangeShow:(BOOL)show {
    if (_changeShow) {
        _changeShow(self, show);
    }
}

- (void)excuteChangeEdit:(BOOL)edit {
    if (_changeEdit) {
        _changeEdit(self, edit);
    }
}

- (void)excuteChangeMust:(BOOL)must {
    if (_changeMust) {
        _changeMust(self, must);
    }
}

- (id)excuteWillGetValue:(id)value {
    if (_willGetValue) {
        return _willGetValue(self, value);
    }
    return value;
}

- (void)excuteDidAction {
    if (_didAction) {
        _didAction(self);
    }
}

- (void)excuteRefreshBlock {
    if (_refreshBlock) {
        _refreshBlock(self);
    }
}


@end
