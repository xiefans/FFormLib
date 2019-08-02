//
//  FFRelationship.h
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , FFRelationshipType) {
    
    FFRelationshipTypeEdit, /**< 不满足时，target不能编辑 */
    FFRelationshipTypeShow, /**< 不满足时，target不显示 */
};

@interface FFRelationship : NSObject

- (instancetype)initWithType:(FFRelationshipType)type;

@property (nonatomic, strong) NSArray *sourceKeys;
@property (nonatomic, strong) NSArray *targetKeys;

@end

