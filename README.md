## FFFramework

### 场景

1. 你的boss让你做一个大量信息录入的界面，类似这样

   | 姓名         | 请输入您的姓名                  |
   | ------------ | ------------------------------- |
   | 性别         | 请输入您的性别                  |
   | 星座         | 请输入您的星座                  |
   | 出生日期     | 请选择您的出生日期              |
   | 出生地       | 请选择您的出生地                |
   | 是否有对象   | 请问您是否有对象 （checkbox）   |
   | 是否有房有车 | 请问您是否有房有车 （checkbox） |

2. 当然，所有的表单提交，表单展示界面。 我都可以满足你

3. 如果你的项目是信息管理系统，那么你就更离不开我了

### 基类

1. 输入/展示 单元（FFView）

   一个基础单元，用来绑定服务器一个字段的单元。 key与服务器字段一致，则为绑定成功。

2. 单元处理器（FFViewManager）

   一个单元都会内置一个单元处理器， 用来处理json数据，必填校验，格式校验（容器处理器）。以及事件的监听和回调

3. 格式校验器（FFFormcatCheck）

   目前只有容器处理器才能处理格式校验器，指定一个key添加校验器，在检查必填校验的时候，会返回是否满足格式

### 示例图 - 包括但不限于 （这是个开放性框架，可以自定义单元并添加到容器中。完全取决于你的大脑）

我比较懒，等你找到对象了再催我做示例图 

### 如何建立自己的单元库

我比较懒，等你找到对象了我再教你建立

