//
//  FFFormcatSpecificCheck.h
//  FansFormFramework
//
//  Created by fans on 2019/8/5.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFFormatCheck.h"

typedef NS_ENUM(NSInteger , FFFormcatSpecificCheckType) {
    FFFormcatSpecificCheckTypeEmail, /**< 验证邮箱格式 */
    FFFormcatSpecificCheckTypePhone, /**< 验证电话格式（手机 | 固话） */
    FFFormcatSpecificCheckTypeMobilePhone, /**< 验证手机号码 */
    FFFormcatSpecificCheckTypeHomePhone, /**< 验证家庭电话 */
    FFFormcatSpecificCheckTypeIdentityCard, /**< 验证身份证格式 */
    FFFormcatSpecificCheckTypeCarNo, /**< 验证车牌号格式 */
};

@interface FFFormcatSpecificCheck : FFFormatCheck

+ (instancetype)formcatCheckWithCheckType:(FFFormcatSpecificCheckType)checkType;

@property (nonatomic, assign, readonly) FFFormcatSpecificCheckType checkType;

@end

