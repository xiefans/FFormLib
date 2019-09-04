//
//  SingleModel.h
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SingleModelType) {
    SingleModelTypeSignleInput,
    SingleModelTypeFixHeightInput,
    SingleModelTypeAutoHeightInput,
    SingleModelTypeSelectItem,
    SingleModelTypeScrollContainer,
    SingleModelTypeAutoHeightContainer,
};

@interface SingleModel : NSObject

- (instancetype)initWithType:(SingleModelType)type;

@property (nonatomic, assign, readonly) SingleModelType type;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subTitle;

- (UIViewController *)controller;

+ (NSString *)infoWithType:(SingleModelType)type;
+ (NSString *)titleWithType:(SingleModelType)type;
+ (UIViewController *)controllerWithType:(SingleModelType)type;

@end
