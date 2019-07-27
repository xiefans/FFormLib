//
//  FansFormView.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansFormViewManager.h"
#import "FansFormConstant.h"

@interface FansFormView : UIView

+ (instancetype)formViewWithKey:(NSString *)key;
+ (instancetype)formViewWithManager:(__kindof FansFormViewManager *)manager;
- (instancetype)initWithKey:(NSString *)key;
- (instancetype)initWithManager:(__kindof FansFormViewManager *)manager;

- (__kindof FansFormViewManager *)manager;

@property (nonatomic, copy, readonly) NSString *key;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, assign, getter=isEdit) BOOL edit;
@property (nonatomic, assign, getter=isMust) BOOL must;

- (void)changeEdit:(BOOL)isEdit;
- (void)changeShow:(BOOL)isShow;
- (void)changeMust:(BOOL)isMust;

- (void)reloadLayout;

@property (nonatomic, assign) UIEdgeInsets paddingInsets; /**< 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginInsets; /**< 内边距 */
@property (nonatomic, assign) CGSize size; /**< 宽高，设置frame 也会改变这个值 */

@property (nonatomic, strong) UIColor *changeTempBackgroundColor; /**< 切换背景色时，暂存之前背景色的 */


@end

