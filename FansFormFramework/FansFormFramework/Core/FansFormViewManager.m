//
//  FansFormViewManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormViewManager.h"

@implementation FansFormViewManager

@synthesize content = _content;
@synthesize value = _value;

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

- (id)content {
    return [self excuteWillGetContent:_content];
}

- (void)setContent:(id)content {
    _content = content;
    [self excuteDidSetContent:content];
}

- (id)value {
    return [self excuteWillGetValue:_value];
}

- (void)setValue:(id)value {
    _value = value;
    [self excuteDidSetValue:value];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self excuteDidSetTitle:title];
}

- (void)excuteChangeShow:(BOOL)show {
    if (_changeShow) {
        _changeShow(self, show);
        [self excuteRefreshBlock];
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

- (void)excuteDidSetValue:(id)value {
    if (_didSetValue) {
        _didSetValue(self, value);
    }
}

- (id)excuteWillGetContent:(id)content {
    if (_willGetContent) {
        return _willGetContent(self, content);
    }
    return content;
}

- (void)excuteDidSetContent:(id)content {
    if (_didSetContent) {
        _didSetContent(self, content);
    }
}

- (void)excuteDidSetTitle:(id)title {
    if (_didSetTitle) {
        _didSetTitle(self, title);
    }
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
