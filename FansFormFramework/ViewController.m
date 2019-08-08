//
//  ViewController.m
//  FFFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ViewController.h"
#import "FFCore.h"
#import "FFTool.h"
#import "FFFormatCheck.h"
@interface ViewController ()

@property (nonatomic, strong) FFScrollContainerItem *formView;

@property (nonatomic, strong) UIButton *checkBtn;

@end

@implementation ViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
    self.formView.frame = layoutFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FFFramework";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.checkBtn];
    
    [self configUI];
    [self configFormcatCheck];
    [self configItemCallback];
    [self configIgnore];
}

- (void)configItemCallback {
    //测试输入组件的回调事件
    FFMagicInputShouldBeginEditing(_formView,
                                   @"1",
                                   ^BOOL(__kindof FFInputView *inputView) {
                                       return YES;
                                   });
    
    FFMagicInputDidEndEditing(_formView,
                              @"1",
                              ^(__kindof FFInputView *inputView) {
                                  
                                  FFFormatCheck *formatCheck = [FFFormatLengthCheck formatCheckWithMinLength:3];
                                  
                                  if (![formatCheck formatCheckWithString:inputView.manager.value]) {
                                      NSLog(@"%@", [formatCheck messageWithTitle:inputView.manager.title]);
                                      
                                      inputView.manager.content = @"";
                                  }
                              });
}

- (void)configIgnore {
    [_formView.manager subManagerForKey:@"select"].ignore = YES;
    [_formView.manager subManagerForKey:@"1"].ignore = YES;
}

- (void)configFormcatCheck {
    //测试 格式校验
    [_formView.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMinLength:3
                                                                          maxLength:6]
                               forKey:@"3"];
}

- (void)configUI {
    _formView = [FFScrollContainerItem formViewWithKey:@"jsonform" layoutDirection:FFContainerViewLayoutDirectionVertical];
    [_formView fans_addKeyboradAdapter];
    //基础表单组件
    [_formView ff_addItem:[FFSelectItem formViewWithTitle:@"地区"
                                                 placeholder:@"请选择地区"
                                               numberOfLines:0
                                                        must:YES
                                                         key:@"select"
                                                   didAction:^(__kindof FFActionView *actionView) {
                                                       
                                                       actionView.manager.content = @"你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了我你选择了";
                                                       actionView.manager.value = @"mustSeee";
                                                   }]];
    [_formView ff_addItem:[FFInputSingleItem formViewWithKey:@"1"
                                                          title:@"名称："
                                                    placeholder:@"请输入名称"
                                                           must:YES]];
    [_formView ff_addItem:[FFFixHeightInputItem formViewWithKey:@"3"
                                                             title:@"名称3："
                                                       placeholder:@"请输入名称3"
                                                         fixHeight:100.f
                                                              must:YES]];
    
    [_formView ff_addItem:[FFAutoHeightInputItem formViewWithKey:@"2"
                                                              title:@"性别："
                                                        placeholder:@"请输入性别"
                                                               must:YES]];
    
    [_formView ff_addItem:[FFInputSingleItem formViewWithKey:@"4"
                                                          title:@"名称4："
                                                    placeholder:@"请输入名称4"
                                                           must:NO]];
    
    //自动size的容器。
    FFAutoHeightContainerItem *item = [FFAutoHeightContainerItem formViewWithKey:@"sub" layoutDirection:FFContainerViewLayoutDirectionHorizontal];
    [item ff_addItem:[FFInputSingleItem formViewWithKey:[NSString stringWithFormat:@"temp%ld",item.subviews.count]
                                                     title:@"temp："
                                               placeholder:@"请输入temp"
                                                      must:YES]];
    [_formView ff_addItem:item];
    
    //这里测试递归检查
    FFContainerView *temp = [FFAutoHeightContainerItem formViewWithKey:@"jjj2"];
    temp.manager.package = YES;
    [temp ff_addItem:[FFAutoHeightInputItem formViewWithKey:@"jj1"
                                                         title:@"组中1："
                                                   placeholder:@"请输入组中1"
                                                          must:NO]];
    [temp ff_addItem:[FFInputSingleItem formViewWithKey:@"jj2"
                                                     title:@"组中2："
                                               placeholder:@"请输入组中2"
                                                      must:YES]];
    [_formView ff_addItem:temp];
    [self.view addSubview:self.formView];
}

- (void)eventOfCheck {
    
    //检查必填项
    BOOL res = [self.formView.manager checkMustWithErrorComplete:^(__kindof FFViewManager *obj, NSString *message) {
        
        if (message) {
            NSLog(@"%@", message);
        } else {
            NSLog(@"%@为空", obj.title);
        }
    }];
    
    if (res) {
        NSLog(@"%@",[self.formView.manager makeDictionary]);
    }
    
    FFAutoHeightContainerItem *item = [self.formView ff_itemForKey:@"sub"];
    FFView *tempView = [FFAutoHeightInputItem formViewWithKey:[NSString stringWithFormat:@"temp%ld",item.subviews.count]
                                                    title:@"temp："
                                              placeholder:@"请输入temp"
                                                     must:YES];
    tempView.size = CGSizeMake(FANSScreenWidth / 3.f, arc4random() % 20 + 30);
    [item ff_addItem:tempView];
    
    [self.formView scrollItemForKey:@"sub" toPosition:FFScrollContainerItemScrollPositionBottom animation:YES];
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc] init];
        [_checkBtn setTitle:@"check" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(eventOfCheck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

@end
