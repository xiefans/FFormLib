//
//  FFViewManager.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 我称 manager 为处理器。 具体manager到底做了什么？
 
 1. 获取绑定View中生成的数据，绑定过程就是view 实现 manager的回调。 让调用者，可以直接设置manager的属性，通过回调影响view的状态。
 2. 将view中生成的数据（value），处理成参与网络请求的数据格式
 3. 必填校验，容器（FFContainerManager）还可以根据设置的校验规则去校验数据规则
 4. 拓展的时候，将逻辑和视图分离。
    但是在拓展的时候，可以很好的将逻辑分离， 大家可以看看我的FFContainerManager 和 FFContainerView
 */

@class FFViewManager;

typedef void(^FFViewManagerChangeShow)(FFViewManager *manager, BOOL isShow);
typedef void(^FFViewManagerChangeEdit)(FFViewManager *manager, BOOL isEdit);
typedef void(^FFViewManagerChangeMust)(FFViewManager *manager, BOOL isMust);
typedef id(^FFViewManagerWillGetValue)(FFViewManager *manager, id value);
typedef void(^FFViewManagerDidSetValue)(FFViewManager *manager, id value);
typedef id(^FFViewManagerWillGetContent)(FFViewManager *manager, id content);
typedef void(^FFViewManagerDidSetContent)(FFViewManager *manager, id content);
typedef void(^FFViewManagerDidSetTitle)(FFViewManager *manager, NSString *title);

typedef void(^FFViewManagerBlock)(FFViewManager *manager);

@interface FFViewManager : NSObject

+ (instancetype)managerWithKey:(NSString *)key;
- (instancetype)initWithKey:(NSString *)key;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, assign, getter=isEdit) BOOL edit;
@property (nonatomic, assign, getter=isMust) BOOL must;

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id content;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) FFViewManagerChangeShow changeShow;
@property (nonatomic, copy) FFViewManagerChangeEdit changeEdit;
@property (nonatomic, copy) FFViewManagerChangeMust changeMust;
@property (nonatomic, copy) FFViewManagerWillGetValue willGetValue;
@property (nonatomic, copy) FFViewManagerDidSetValue didSetValue;
@property (nonatomic, copy) FFViewManagerDidSetContent didSetContent;
@property (nonatomic, copy) FFViewManagerWillGetContent willGetContent;
@property (nonatomic, copy) FFViewManagerDidSetTitle didSetTitle;

@property (nonatomic, copy) FFViewManagerBlock didAction;
@property (nonatomic, copy) FFViewManagerBlock refreshBlock; /**< 通知容器刷新 */

- (void)excuteChangeShow:(BOOL)show;
- (void)excuteChangeEdit:(BOOL)edit;
- (void)excuteChangeMust:(BOOL)must;
- (id)excuteWillGetValue:(id)value;
- (void)excuteDidSetValue:(id)value;
- (id)excuteWillGetContent:(id)content;
- (void)excuteDidSetContent:(id)content;
- (void)excuteDidSetTitle:(id)title;
- (void)excuteDidAction;
- (void)excuteRefreshBlock;

- (NSDictionary *)makeDictionary;
- (NSString *)makeJSONString;

- (BOOL)checkMust;

@end
