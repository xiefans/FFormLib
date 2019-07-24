//
//  FansFormAbstractItem.h
//  FansFormFramework
//
//  Created by fans on 2019/7/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//


#import "FansFormItemConstant.h"
#import "FansFormTool.h"

#if DEBUG

static BOOL const FansFormItemIsLogInCommandLine = YES;

#else

static BOOL const FansFormItemIsLogInCommandLine = NO;

#endif

@class FansFormAbstractItem,FansFormItemStyle;

typedef void(^FansFormItemBlock)(FansFormAbstractItem *item);
typedef id(^FansFormItemHandleValueBlock)(FansFormAbstractItem *item, id value);

@interface FansFormAbstractItem : NSObject

- (instancetype)initWithKey:(NSString *)key;


/**
 通知容器刷新UI的回调
 */
@property (nonatomic, copy) FansFormItemBlock refreshBlock;

/**
 提供配置 item的block
 */
@property (nonatomic, copy) FansFormItemBlock configBlock;

/**
 在获取value的时候，会调用这个回调
 */
@property (nonatomic, copy) FansFormItemHandleValueBlock handleValueBlock;

/**
 是否必填
 */
@property (nonatomic, assign ,getter=isMust) BOOL must;
- (instancetype)changeToMust;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 key （唯一标识）
 */
@property (nonatomic, copy) NSString *key;

/**
 请求时提交给后台的内容
 */
@property (nonatomic, strong) id value;

/**
 显示的内容 (可能是数据结构)
 */
@property (nonatomic, strong) id content;

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
@property (nonatomic, strong, readonly) __kindof UIView *contentView;

/**
 contentView展示的大小。
 */
@property (nonatomic, assign) CGSize showSize;

/**
 原始尺寸（在切换show时，保存下一开始的size）
 */
@property (nonatomic, assign) CGSize orgSize;

/**
 是否可以编辑
 */
@property (nonatomic, assign, getter=isEdit) BOOL edit;

/**
 是否显示
 */
@property (nonatomic, assign, getter=isShow) BOOL show;


#pragma mark Item<Data>

/**
 是否将subItems们的参数，打包成NSDictionary （默认不打包）。
 */
@property (nonatomic, assign, getter=isPackage) BOOL package;

- (NSString *)makeJSONString;
- (NSDictionary *)makeDictionary;

@end
