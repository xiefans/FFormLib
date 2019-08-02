//
//  FFContainerView.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"
#import "FFContainerManager.h"

/* 默认的容器类 */
@interface FFContainerView : FFView

@property (nonatomic, strong) NSMutableDictionary *map;

- (__kindof FFContainerManager *)manager;

- (void)ff_addSubview:(__kindof FFView *)view;
- (void)ff_removeSubviewForKey:(NSString *)key;
- (__kindof FFView *)ff_subviewForKey:(NSString *)key;
- (NSArray<__kindof FFView *> *)ff_subviews;




@end
