//
//  FansFormAbstractItem.m
//  FansFormFramework
//
//  Created by fans on 2019/7/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"


@interface FansFormAbstractItem ()

@property (nonatomic, strong) NSMutableDictionary *paramsMap;

@end

@implementation FansFormAbstractItem

#pragma mark - Overrides
- (instancetype)init {
    if (self = [super init]) {
        _edit = YES;
        _show = YES;
    }
    return self;
}

#pragma mark - Public Method
- (instancetype)initWithKey:(NSString *)key {
    if (self = [self init]) {
        self.key = key;
    }
    return self;
}

- (void)setShowSize:(CGSize)showSize {
    _showSize = showSize;
    self.contentView.fans_size = showSize;
    if (self.refreshBlock) {
        self.refreshBlock(self);
    }
}

- (void)addParam:(id)param key:(NSString *)key {
    [self.paramsMap setObject:param forKey:key];
}

- (NSDictionary *)params {
    return [self.params copy];
}

- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    id value = self.value;
    
    if (self.key && value) {
        [dict setObject:value forKey:self.key];
    }
    
    return dict;
}

- (NSString *)makeJSONString {
    NSDictionary *params = [self makeDictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (UIView *)contentView {
    return nil;
}

- (void)setShow:(BOOL)show {
    _show = show;
    if (show) {
        self.showSize = _orgSize;
    } else {
        _orgSize = self.contentView.fans_size;
        self.showSize = CGSizeMake(0.f, 0.f);
    }
    
    self.contentView.hidden = !show;
}

- (id)value {
    if (self.handleValueBlock) {
        return self.handleValueBlock(self, _value);
    }
    return _value;
}

- (instancetype)changeToMust {
    
    [self setMust:YES];
    
    return self;
}

#pragma mark - Lazy Load
- (NSMutableDictionary *)paramsMap {
    if (!_paramsMap) {
        _paramsMap = [NSMutableDictionary new];
    }
    return _paramsMap;
}

@end
