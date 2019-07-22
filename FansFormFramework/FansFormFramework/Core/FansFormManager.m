//
//  FansFormManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormManager.h"

#if DEBUG

static BOOL const kIsLogInCommandLine = YES;

#else

static BOOL const kIsLogInCommandLine = NO;

#endif


@interface FansFormManager ()

@property (nonatomic, strong) NSMutableDictionary *itemMap;

@end

@implementation FansFormManager

#pragma mark - Protocol
#pragma mark <FansFormManagerInterface>
- (id<FansFormItemInterface>)itemForKey:(NSString *)key {
    id<FansFormItemInterface> item = self.itemMap[key];
    
    if (!item && kIsLogInCommandLine) {
        NSLog(@"Item(key : %@) not found in %@",key , self.class);
    }
    
    return self.itemMap[key];
}

- (void)addItem:(id<FansFormItemInterface>)item {
    [self.itemMap setObject:item forKey:item.key];
}

- (NSString *)toJSONString {
    NSDictionary *dict = [self toDictionary];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [self.itemMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<FansFormItemInterface>  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [dict setObject:obj.requestContent forKey:key];
    }];
    
    return dict;
}

#pragma mark - Lazy Load
- (NSMutableDictionary *)itemMap {
    if (!_itemMap) {
        _itemMap = [NSMutableDictionary new];
    }
    return _itemMap;
}

@end
