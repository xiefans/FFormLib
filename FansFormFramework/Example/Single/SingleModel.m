//
//  Single_m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "SingleModel.h"
#import "SingleInputViewController.h"
#import "FixHeightInputViewController.h"
#import "AutoHeightInputViewController.h"
#import "SelectItemViewController.h"
#import "ScrollContainerViewController.h"
#import "AutoHeightContainerViewController.h"

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
            return @"单行输入组件。";
        case SingleModelTypeFixHeightInput:
            return @"多行输入组件，高度固定可设置。";
        case SingleModelTypeAutoHeightInput:
            return @"多行输入组件，高度随内容撑开。";
        case SingleModelTypeSelectItem:
            return @"响应单击事件的组件，可以展示选择的数据以其他形式展示的组件， 例如日期选择。";
        case SingleModelTypeScrollContainer:
            return @"容器组件， 设置固定的高度，在这个高度内可以滑动。\n可以添加其他子组件";
        case SingleModelTypeAutoHeightContainer:
            return @"容器组件， 高度随着子组件的内容撑开。\n可以添加其他子组件";
        default:
            return nil;
    }
}

+ (NSString *)tipWithType:(SingleModelType)type {
    switch (type) {
        case SingleModelTypeSignleInput:
            return @"单行输入组件 \n可以添加在容器视图中使用";
        case SingleModelTypeFixHeightInput:
            return @"多行输入组件 \n1. 高度固定可设置\n2. 可以添加在容器视图中使用";
        case SingleModelTypeAutoHeightInput:
            return @"多行输入组件 \n1. 高度随内容撑开\n2. 可以添加在容器视图中使用";
        case SingleModelTypeSelectItem:
            return @"响应单击事件的组件 \n该组件比较通用，响应点击事件之后，可以做任何操作，最后把操作的结果给到该组件的manager，参与json生成以及展示";
        case SingleModelTypeScrollContainer:
            return @"容器组件 \n1. 设置固定的高度，在这个高度内可以滑动\n2. 可以添加其他子组件\n3. 可以选择子组件的布局方向";
        case SingleModelTypeAutoHeightContainer:
            return [NSString stringWithFormat:@"容器组件 \n1. 高度随着子组件的内容撑开\n2. 可以将该组件添加到%@中，会有更好的体验效果\n3. 可以添加其他子组件\n4. 可以选择子组件的布局方向", [self titleWithType:SingleModelTypeScrollContainer]];
        default:
            return nil;
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
    }
}

+ (UIViewController *)controllerWithType:(SingleModelType)type {
    ExampleSingleViewController *exampleController = nil;
    switch (type) {
        case SingleModelTypeSignleInput: {
            SingleInputViewController *vc = [[SingleInputViewController alloc] init];
            exampleController = vc;
        }
            break;
        case SingleModelTypeFixHeightInput:{
            FixHeightInputViewController *vc = [[FixHeightInputViewController alloc] init];
            exampleController = vc;
        }
            break;
        case SingleModelTypeAutoHeightInput:{
            AutoHeightInputViewController *vc = [[AutoHeightInputViewController alloc] init];
            exampleController = vc;
        }
            break;
        case SingleModelTypeSelectItem:{
            SelectItemViewController *vc = [[SelectItemViewController alloc] init];
            exampleController = vc;
        }
            break;
        case SingleModelTypeScrollContainer:{
            ScrollContainerViewController *vc = [ScrollContainerViewController new];
            exampleController = vc;
        }
            break;
        case SingleModelTypeAutoHeightContainer:{
            AutoHeightContainerViewController *vc = [AutoHeightContainerViewController new];
            exampleController = vc;
        }
            break;
        default:
            exampleController = [[ExampleSingleViewController alloc] init];
            break;
    }
    exampleController.type = type;
    return exampleController;
}

@end
