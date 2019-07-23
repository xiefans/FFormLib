//
//  UIView+FansForm.h
//  FansFormFramework
//
//  Created by fans on 2019/7/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FansFormAbstractItem;
@interface UIView (FansForm)

- (void)fans_addSubItem:(FansFormAbstractItem *)item;
- (void)fans_removeSubItemForKey:(NSString *)key;
- (__kindof FansFormAbstractItem *)fans_subItemForKey:(NSString *)key;

/**
 当只有一个item的时候，返回item。 否则是nil

 @return item
 */
- (__kindof FansFormAbstractItem *)fans_subItem;

@end

