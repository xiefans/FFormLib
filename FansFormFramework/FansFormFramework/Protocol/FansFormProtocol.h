//
//  FansFormProtocol.h
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#pragma mark - ItemView

@protocol FansFormItemViewInterface <NSObject>

/**
 返回itemView在容器中的布局大小。  注意在容器中任何的x和y都没有作用，只会获取该size去设置大小

 @return 布局大小
 */
- (CGSize)getLayoutSize;

@end

#pragma mark - Item
/**
 如果实现该接口
 该对象可以被作为一个item ，添加到容器中。
 @mark :
 item必须实现一个设置key的初始化方法，key是item在容器中的唯一标识。也是通过处理器获取请求json时和服务器对接的key
 */
@protocol FansFormItemInterface <NSObject>

#pragma mark Item<Base>

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
 一般来说容器是一个view，但是接口中我并没有做限制，不想限制大家的想象力，因为在大家的业务中容器不一定是用来展示用的。
 这个方法是为了迎合我实际场景。 我的容器就是用来展示的

 @return 展示view
 */
- (UIView *)contentView;

- (void)noEdit;
- (void)edit;

- (void)show;
- (void)hide;

@end

#pragma mark - Manager

/**
 如果实现了这个借口
 则该对象是可以处理item之间逻辑的对象
 */
@protocol FansFormManagerInterface <NSObject>



@end

#pragma mark - Container
/**
 如果实现了这个接口
 则该对象是可以作为容器使用。可以添加其他的item
 */
@protocol FansFormContainerInterface <FansFormItemInterface>

/**
 创建一个带处理器的容器，可以处理item之间的逻辑

 @param manager 处理器
 @return 容器
 */
+ (instancetype)containerWithManager:(id<FansFormManagerInterface>)manager;

/**
 获取处理器

 @return 处理器
 */
- (id<FansFormManagerInterface>)manager;

/**
 添加一个item到容器中,添加的同时，需要把item交给处理器。

 @param item item
 */
- (void)addItem:(id<FansFormItemInterface>)item;

@end


