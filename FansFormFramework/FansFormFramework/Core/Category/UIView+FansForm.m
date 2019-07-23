//
//  UIView+FansForm.m
//  FansFormFramework
//
//  Created by fans on 2019/7/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "UIView+FansForm.h"
#import "FansFormAbstractItem.h"
#import <objc/runtime.h>

@implementation UIView (FansForm)

- (void)fans_addSubItem:(FansFormAbstractItem *)item {
    [self.itemMap setObject:item forKey:item.key];
    [self addSubview:item.contentView];
}

- (FansFormAbstractItem *)fans_subItem {
    if (self.itemMap.count == 1) {
        return self.itemMap.allValues.firstObject;
    }
    return nil;
}

- (FansFormAbstractItem *)fans_subItemForKey:(NSString *)key {
    return self.itemMap[key];
}

- (void)fans_removeSubItemForKey:(NSString *)key {
    
    FansFormAbstractItem *item = [self fans_subItemForKey:key];
    
    if (item) {
        [self.itemMap removeObjectForKey:key];
        [item.contentView removeFromSuperview];
    }
}


- (NSMutableDictionary *)itemMap {
    
    NSMutableDictionary *itemMap = objc_getAssociatedObject(self, "itemMap");
    if (!itemMap) {
        itemMap = [NSMutableDictionary new];
        objc_setAssociatedObject(self, "itemMap", itemMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return itemMap;
}

@end
