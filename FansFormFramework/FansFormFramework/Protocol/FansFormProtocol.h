//
//  FansFormProtocol.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Item
/**
 如果实现该接口
 该对象可以被作为一个item ，添加到容器中。
 @mark :
 item必须实现一个设置key的初始化方法，key是item在容器中的唯一标识。也是通过处理器获取请求json时和服务器对接的key
 */
@protocol FansFormItemInterface;
typedef void(^FansFormItemRefreshBlock)(id<FansFormItemInterface> item);
typedef void(^FansFormItemGetSizeBlock)(id<FansFormItemInterface> item, CGFloat *width ,CGFloat *height);
@protocol FansFormItemInterface <NSObject>

#pragma mark Item<Base>

/**
 通知容器刷新UI的回调
 */
@property (nonatomic, copy) FansFormItemRefreshBlock refreshBlock;

/**
 获取view视图大小的回调
 */
@property (nonatomic, copy) FansFormItemGetSizeBlock getSizeBlock;

/**
 必填
 */
@property (nonatomic, assign ,getter=isMust) BOOL must;

/**
 标题，item的对用户展示的友好名称

 @return 标题
 */
- (NSString *)title;

/**
 获取item的key

 @return item的key
 */
- (NSString *)key;

/**
 设置请求时的参数（value）
 @mark :
 在生成json时，这个值会做为value和key对应起来。

 @param requestContent 请求参数（value）
 */
- (void)setRequestContent:(NSString *)requestContent;

/**
 获取请求参数（value）

 @return 获取请求参数
 */
- (NSString *)requestContent;

/**
 设置显示的内容

 @param content 显示的内容
 */
- (void)setShowContent:(NSString *)content;

/**
 获取显示的内容

 @return 显示的内容
 */
- (NSString *)showContent;

/**
 添加额外参数
 @mark :
 有时候这个item需要借助其他item的信息去获取自己应该展示的信息，可以用到该方法

 @param param value
 @param key key
 */
- (void)addParam:(id)param key:(NSString *)key;
- (NSDictionary *)params;

#pragma mark Item<UI>

/**
 获取展示用的View
 @mark :
 一般来说容器是一个view，但是接口中我并没有做限制，因为在大家的业务中容器不一定是用来展示用的。
 这个方法是为了迎合我实际场景。 我的容器就是用来展示的

 @return 展示view
 */
- (UIView *)contentView;

- (void)noEdit;
- (void)edit;
- (BOOL)isEdit;

- (void)show;
- (void)hide;
- (BOOL)isShow;

@end

#pragma mark - Manager

/**
 如果实现了这个接口
 则该对象是可以处理item之间逻辑的对象（处理器）
 */
@protocol FansFormManagerInterface <NSObject>

/**
 添加一个item到处理器中
 
 @param item item
 */
- (void)addItem:(id<FansFormItemInterface>)item;

/**
 根据key找到item
 
 @param key key
 @return item
 */
- (id<FansFormItemInterface>)itemForKey:(NSString *)key;

- (NSString *)toJSONString;
- (NSDictionary *)toDictionary;


@end

#pragma mark - Container
/**
 如果实现了这个接口
 则该对象是可以作为容器使用。可以添加其他的item
 */
@protocol FansFormContainerInterface <FansFormManagerInterface>

/**
 创建一个带处理器的容器，可以处理item之间的逻辑

 @param manager 处理器
 @return 容器
 */
+ (instancetype)containerWithManager:(id<FansFormManagerInterface>)manager;

/**
 返回所有的item

 @return item数组
 */
- (NSArray<FansFormItemInterface> *)subItems;

@end


