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

@property (nonatomic, strong) FFContainerView *formView;

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
    
    _formView = [FFContainerView formViewWithKey:@"jsonform"];
    [_formView fans_adapterKeyborad];
    
    [_formView addSubview:[FFSelectItem formViewWithTitle:@"地区"
                                              placeholder:@"请选择地区"
                                         instructionImage:nil
                                            numberOfLines:0
                                                     must:YES
                                                      key:@"select"
                                                didAction:^(__kindof FFActionView *actionView) {
                                                    
                                                    actionView.manager.content = @"你选择了我";
                                                    actionView.manager.value = @"mustSeee";
                                                    
                                                }]];
    
    [_formView addSubview:[FFInputView formViewWithKey:@"1"
                                                 title:@"名称："
                                           placeholder:@"请输入名称"
                                                  must:YES]];
    [_formView addSubview:[FFFixHeightInputItem formViewWithKey:@"3"
                                                          title:@"名称3："
                                                    placeholder:@"请输入名称3"
                                                      fixHeight:100.f
                                                           must:YES]];
    
    [_formView addSubview:[FFAutoHeightInputItem formViewWithKey:@"2"
                                                           title:@"性别："
                                                     placeholder:@"请输入性别"
                                                            must:YES]];
    
    [_formView addSubview:[FFInputView formViewWithKey:@"4"
                                                 title:@"名称4："
                                           placeholder:@"请输入名称4"
                                                  must:NO]];
    
    
    
    //这里测试递归检查
    FFContainerView *temp = [FFContainerView formViewWithKey:@"jjj2"];
    temp.size = CGSizeMake(0.f, 120.f);
    temp.manager.package = YES;
    [temp addSubview:[FFInputView formViewWithKey:@"jj1"
                                            title:@"组中1："
                                      placeholder:@"请输入组中1"
                                             must:NO]];
    [temp addSubview:[FFInputView formViewWithKey:@"jj2"
                                            title:@"组中2："
                                      placeholder:@"请输入组中2"
                                             must:YES]];
    [_formView addSubview:temp];
    [self.view addSubview:self.formView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.checkBtn];
    
    //测试 格式校验
    [_formView.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMinLength:3
                                                                          maxLength:6]
                          forKey:@"3"];
}

- (void)eventOfCheck {
    [self.view endEditing:YES];
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
