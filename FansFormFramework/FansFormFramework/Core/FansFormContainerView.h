//
//  FansFormContainerView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormView.h"
#import "FansFormContainerManager.h"

@interface FansFormContainerView : FansFormView

- (__kindof FansFormContainerManager *)manager;

- (void)addSubview:(__kindof FansFormView *)view;
- (void)removeSubviewForKey:(NSString *)key;
- (__kindof FansFormView *)subviewForKey:(NSString *)key;
- (NSArray<__kindof FansFormView *> *)subviews;


@end
