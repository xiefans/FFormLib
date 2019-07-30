//
//  FansFormViewManager.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FansFormViewManager;

typedef void(^FansFormViewManagerChangeShow)(FansFormViewManager *manager, BOOL isShow);
typedef void(^FansFormViewManagerChangeEdit)(FansFormViewManager *manager, BOOL isEdit);
typedef void(^FansFormViewManagerChangeMust)(FansFormViewManager *manager, BOOL isMust);
typedef id(^FansFormViewManagerWillGetValue)(FansFormViewManager *manager, id value);
typedef void(^FansFormViewManagerDidSetValue)(FansFormViewManager *manager, id value);
typedef id(^FansFormViewManagerWillGetContent)(FansFormViewManager *manager, id content);
typedef void(^FansFormViewManagerDidSetContent)(FansFormViewManager *manager, id content);
typedef void(^FansFormViewManagerDidSetTitle)(FansFormViewManager *manager, NSString *title);

typedef void(^FansFormViewManagerBlock)(FansFormViewManager *manager);

@interface FansFormViewManager : NSObject

+ (instancetype)managerWithKey:(NSString *)key;
- (instancetype)initWithKey:(NSString *)key;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, assign, getter=isEdit) BOOL edit;
@property (nonatomic, assign, getter=isMust) BOOL must;

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id content;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) FansFormViewManagerChangeShow changeShow;
@property (nonatomic, copy) FansFormViewManagerChangeEdit changeEdit;
@property (nonatomic, copy) FansFormViewManagerChangeMust changeMust;
@property (nonatomic, copy) FansFormViewManagerWillGetValue willGetValue;
@property (nonatomic, copy) FansFormViewManagerDidSetValue didSetValue;
@property (nonatomic, copy) FansFormViewManagerDidSetContent didSetContent;
@property (nonatomic, copy) FansFormViewManagerWillGetContent willGetContent;
@property (nonatomic, copy) FansFormViewManagerDidSetTitle didSetTitle;

@property (nonatomic, copy) FansFormViewManagerBlock didAction;
@property (nonatomic, copy) FansFormViewManagerBlock refreshBlock; /**< 通知容器刷新 */

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
