//
//  Single_m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "SingleModel.h"
#import "SingleInputViewController.h"

@implementation SingleModel

- (instancetype)initWithType:(SingleModelType)type {
    if (self = [super init]) {
        _type = type;
        _title = [SingleModel titleWithType:type];
        _subTitle = [SingleModel infoWithType:type];
    }
    return self;
}

- (UIViewController *)controller {
    return [SingleModel controllerWithType:self.type];
}

+ (NSString *)infoWithType:(SingleModelType)type {
    switch (type) {
        case SingleModelTypeSignleInput:
            return @"单行输入组件， 需要添加在容器组件中使用";
        case SingleModelTypeFixHeightInput:
            return @"多行输入组件，高度固定可设置， 需要添加在容器组件中使用";
        case SingleModelTypeAutoHeightInput:
            return @"多行输入组件，高度随内容撑开， 需要添加在容器组件中使用";
        case SingleModelTypeSelectItem:
            return @"响应单击事件的组件，可以展示选择的数据以其他形式展示的组件， 例如日期选择， 需要添加在容器组件中使用";
        case SingleModelTypeScrollContainer:
            return @"容器组件， 设置固定的高度，在这个高度内可以滑动。 可以添加其他子组件";
        case SingleModelTypeAutoHeightContainer:
            return @"容器组件， 高度随着子组件的内容撑开。 可以添加其他子组件";
        default:
            return nil;
            break;
    }
}

+ (NSString *)titleWithType:(SingleModelType)type {
    switch (type) {
        case SingleModelTypeSignleInput:
            return @"SingleInput";
        case SingleModelTypeFixHeightInput:
            return @"FixHeightInput";
        case SingleModelTypeAutoHeightInput:
            return @"AutoHeightInput";
        case SingleModelTypeSelectItem:
            return @"SelectItem";
        case SingleModelTypeScrollContainer:
            return @"ScrollContainer";
        case SingleModelTypeAutoHeightContainer:
            return @"AutoHeightContainer";
        default:
            return nil;
            break;
    }
}

+ (UIViewController *)controllerWithType:(SingleModelType)type {
    ExampleViewController *exampleController = nil;
    switch (type) {
        case SingleModelTypeSignleInput: {
            SingleInputViewController *vc = [[SingleInputViewController alloc] init];
            exampleController = vc;
        }
            break;
            
        default:
            exampleController = [[ExampleViewController alloc] init];
            break;
    }
    exampleController.type = type;
    return exampleController;
}

@end
