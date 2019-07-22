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

- (void)setShowContent:(NSString *)content forItemKey:(NSString *)itemKey {
    [self itemForKey:itemKey].showContent = content;
}

- (NSString *)showContentForItemkey:(NSString *)itemKey {
    return [self itemForKey:itemKey].showContent;
}

- (void)setRequestContent:(NSString *)requestContent forItemkey:(NSString *)itemKey {
    [self itemForKey:itemKey].requestContent = requestContent;
}

- (NSString *)requestContentForItemkey:(NSString *)itemKey {
    return [self itemForKey:itemKey].requestContent;
}

- (void)addParam:(id)param key:(NSString *)key forItemKey:(NSString *)itemKey {
    [[self itemForKey:itemKey] addParam:param key:key];
}

- (NSDictionary *)paramsForItemKey:(NSString *)itemKey {
    return [self itemForKey:itemKey].params;
}

- (void)noEditForItemKey:(NSString *)itemKey {
    id<FansFormItemInterface> item = [self itemForKey:itemKey];
    if (item.isEdit) {
        [item noEdit];
    } else if (kIsLogInCommandLine) {
        NSLog(@"%@： Item(key : %@) Already noEdit",self.class, itemKey);
    }
}

- (void)editForItemKey:(NSString *)itemKey {
    id<FansFormItemInterface> item = [self itemForKey:itemKey];
    if (!item.isEdit) {
        [item edit];
    } else if (kIsLogInCommandLine) {
        NSLog(@"%@： Item(key : %@) Already edit",self.class, itemKey);
    }
}

- (void)showForKey:(NSString *)itemKey {
    id<FansFormItemInterface> item = [self itemForKey:itemKey];
    if (!item.isShow) {
        [item show];
        
    } else if (kIsLogInCommandLine) {
        NSLog(@"%@： Item(key : %@) Already shown",self.class, itemKey);
    }
}

- (void)hideForKey:(NSString *)itemKey {
    id<FansFormItemInterface> item = [self itemForKey:itemKey];
    if (item.isShow) {
        [item hide];
    } else if (kIsLogInCommandLine) {
        NSLog(@"%@： Item(key : %@) Already hidden",self.class, itemKey);
    }
}


#pragma mark - Lazy Load
- (NSMutableDictionary *)itemMap {
    if (!_itemMap) {
        _itemMap = [NSMutableDictionary new];
    }
    return _itemMap;
}

@end
