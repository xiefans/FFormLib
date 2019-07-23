//
//  FansFormProtocol.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//
//#pragma mark - Item
///**
// 如果实现该接口
// 该对象可以被作为一个item ，添加到容器中。
// @mark :
// item必须实现一个设置key的初始化方法，key是item在容器中的唯一标识。也是通过处理器获取请求json时和服务器对接的key
// */
//@protocol FansFormItemInterface;
//typedef void(^FansFormItemBlock)(id<FansFormItemInterface> item);
//@protocol FansFormItemInterface <NSObject>
//
//#pragma mark Item<Base>
//
///**
// 通知容器刷新UI的回调
// */
//@property (nonatomic, copy) FansFormItemBlock refreshBlock;
//
///**
// 提供配置 item的block
// */
//@property (nonatomic, copy) FansFormItemBlock configBlock;
//
///**
// 是否必填
// */
//@property (nonatomic, assign ,getter=isMust) BOOL must;
//
///**
// 标题
// */
//@property (nonatomic, copy) NSString *title;
//
///**
// key （唯一标识）
// */
//@property (nonatomic, copy, readonly) NSString *key;
//
///**
// 请求时提交给后台的内容
// */
//@property (nonatomic, copy) NSString *value;
//
///**
// 显示的内容
// */
//@property (nonatomic, copy) NSString *content;
//
//
//
///**
// 添加额外参数
// @mark :
// 有时候这个item需要借助其他item的信息去获取自己应该展示的信息，可以用到该方法
//
// @param param value
// @param key key
// */
//- (void)addParam:(id)param key:(NSString *)key;
//- (NSDictionary *)params;
//
//#pragma mark Item<UI>
//
///**
// 获取展示用的View
// @mark :
// 一般来说容器是一个view，但是接口中我并没有做限制，因为在大家的业务中容器不一定是用来展示用的。
// 这个方法是为了迎合我实际场景。 我的容器就是用来展示的
//
// @return 展示view
// */
//@property (nonatomic, strong, readonly) UIView *contentView;
//
///**
// contentView展示的大小。
// */
//@property (nonatomic, assign) CGSize showSize;
//
///**
// 是否可以编辑
// */
//@property (nonatomic, assign, getter=isEdit) BOOL edit;
//
///**
// 是否显示
// */
//@property (nonatomic, assign, getter=isShow) BOOL show;
//
///**
// 子item数组
// */
//@property (nonatomic, strong, readonly) NSArray<FansFormItemInterface> *subItems;
//
//- (void)addSubItem:(id<FansFormItemInterface>)item;
//- (void)removeSubItemForKey:(NSString *)key;
//- (id<FansFormItemInterface>)itemForKey:(NSString *)key;
//
//#pragma mark Item<Data>
//
///**
// 是否将subItems们的参数，打包成NSDictionary （默认不打包）。
// */
//@property (nonatomic, assign, getter=isPackage) BOOL package;
//
//- (NSString *)makeJSONString;
//- (NSDictionary *)makeDictionary;
//
//@end


