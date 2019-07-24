# FansFormFramework

## 使用说明

- 为什么使用该框架？

  如果你要在App上实现一个大信息量的表单提交，那么你应该学习一下该框架。

  如果没有该框架，你的代码是这样的。

  ```objective-c
  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    	if (indexPath.row == 0) {
        //这是第一个输入项
        
      }  else if (indexPath.row == 1) {
        //这是第二个输入项
        
      }
    	
    	......
    
  }
  
  - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      if (indexPath.row == 0) {
        //这是第一个输入项触发的事件
        
      }  else if (indexPath.row == 1) {
        //这是第二个输入项触发的事件
        
      }
    	
    	......
  }
  
  //校验提交的数据
  - (void)check {
    //取第一个
    
    // 取第二个
    
    .....
  }
  
  
  //提交参数
  - (void)submit {
    //取第一个
    
    // 取第二个
    
    .....
  }
  ```

  如果你使用了该框架

  ```objective-c
  - (void)viewDidLoad {
      [super viewDidLoad];
      self.title = @"好的";
      self.view.backgroundColor = [UIColor whiteColor];
      
      FansFormManager *formManager = [[FansFormManager alloc] initWithKey:@"jsonform"];
  
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
                                               //这里可以转换为服务器想要的格式
                                                 return [NSString stringWithFormat:@"%@",value];
                                             }]];
      
      
      [self.view fans_addSubItem:formManager];
  }
  
  - (void)submit {
    
    NSString *json = FansViewSubItem.makeJSONString;
    
    //提交
    
  }
  ```

  提交就是这么简单！！   目前check还在开发中，大家敬请期待

## 日志

- 2019 / 07 / 24   V 1.1

  整理架构，修改了基类接口

  新增多行输入组件

  新增时间选择组件





