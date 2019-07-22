//
//  FansFormManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormManager.h"

@implementation FansFormManager

#pragma mark - Protocol
#pragma mark <FansFormManagerInterface>
- (id<FansFormItemInterface>)itemForKey:(NSString *)key {
    return nil;
}

- (void)addItem:(id<FansFormItemInterface>)item {
    
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
    [[self itemForKey:itemKey] noEdit];
}

- (void)editForItemKey:(NSString *)itemKey {
    [[self itemForKey:itemKey] edit];
}

- (void)showForKey:(NSString *)itemKey {
    [[self itemForKey:itemKey] show];
}

- (void)hideForKey:(NSString *)itemKey {
    [[self itemForKey:itemKey] hide];
}



@end
