//
//  FFViewManager.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

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
