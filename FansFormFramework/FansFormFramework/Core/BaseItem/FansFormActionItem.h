//
//  FansFormActionItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormAbstractItem.h"


@interface FansFormActionItem : FansFormAbstractItem

/**
 触发的事件
 */
@property (nonatomic, copy) FansFormItemBlock actionBlock;

@end
