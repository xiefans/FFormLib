//
//  ViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ViewController.h"
#import "FansFormCore.h"
#import "FansFormSupportItem.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FansFormManager *formManager;

@end

@implementation ViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
    
    FansViewSubItem.contentView.frame = layoutFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    FansFormManager *formManager = [[FansFormManager alloc] initWithKey:@"jsonform"];
//    formManager.package = YES;
    [formManager addSubItem:[FansInputItem itemWithTitle:@"单行文本"
                                             placeholder:@"请输入单行文本"
                                                  forKey:@"input"].changeToMust];
    
    [formManager addSubItem:[FansInputItem itemWithTitle:@"单行文本2"
                                             placeholder:@"请输入单行文本2"
                                                  forKey:@"param3"]];
    
    [formManager addSubItem:[FansTextItem itemWithTitle:@"多行文本"
                                            placeholder:@"请输入多行文本"
                                                 forKey:@"param2"].changeToMust];
    
    [formManager addSubItem:[FansFormDateItem itemWithTitle:@"日期选择"
                                                        key:@"date"
                                           handleValueBlock:^id(FansFormAbstractItem *item, NSDate *value) {
                                               
                                               NSLog(@"%@",item.class);
                                               return [NSString stringWithFormat:@"%@",value];
                                           }]];
    
    
    [self.view fans_addSubItem:formManager];
    
    [formManager.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(action)]];
}

- (void)action {
    NSLog(@"dict :%@ \n json : %@",FansViewSubItem.makeDictionary,FansViewSubItem.makeJSONString);
    
    if (FansManagerGetItem(FansViewSubItem, @"param2").isShow) {
        FansManagerGetItem(FansViewSubItem, @"param2").show = NO;
    } else {
        FansManagerGetItem(FansViewSubItem, @"param2").show = YES;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
