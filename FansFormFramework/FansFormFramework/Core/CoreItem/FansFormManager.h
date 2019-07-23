//
//  FansFormManager.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"


@interface FansFormManager : FansFormAbstractItem

+ (instancetype)managerWithDirection:(FansFormArrangeDirection)direction;



/**
 子item数组
 */
@property (nonatomic, strong, readonly) NSArray<FansFormAbstractItem *> *subItems;

- (void)addSubItem:(FansFormAbstractItem *)item;
- (void)removeSubItemForKey:(NSString *)key;
- (FansFormAbstractItem *)itemForKey:(NSString *)key;

@end

