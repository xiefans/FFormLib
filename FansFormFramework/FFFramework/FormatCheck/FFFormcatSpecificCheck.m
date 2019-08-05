//
//  FFFormcatSpecificCheck.m
//  FansFormFramework
//
//  Created by fans on 2019/8/5.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFFormcatSpecificCheck.h"

@implementation FFFormcatSpecificCheck

+ (instancetype)formcatCheckWithCheckType:(FFFormcatSpecificCheckType)checkType {
    return [[self alloc] initWithCheckType:checkType];
}

- (instancetype)initWithCheckType:(FFFormcatSpecificCheckType)checkType {
    if (self = [super init]) {
        _checkType = checkType;
    }
    return self;
}

- (BOOL)formatCheckWithString:(NSString *)string {
    switch (self.checkType) {
        case FFFormcatSpecificCheckTypeEmail:
            return [self ff_verifyForEmail:string];
            break;
        case FFFormcatSpecificCheckTypePhone:
            return [self ff_verifyForPhone:string];
            break;
        case FFFormcatSpecificCheckTypeMobilePhone:
            return [self ff_verifyForMobile:string];
            break;
        case FFFormcatSpecificCheckTypeHomePhone:
            return [self ff_verifyForHomePhone:string];
            break;
        case FFFormcatSpecificCheckTypeIdentityCard:
            return [self ff_verifyForIdentityCard:string];
            break;
        case FFFormcatSpecificCheckTypeCarNo:
            return [self ff_verifyForCarNo:string];
            break;
    }
    return NO;
}

- (NSString *)messageWithTitle:(NSString *)title {
    return [NSString stringWithFormat:@"%@格式不正确",title];
}

- (BOOL)ff_verifyForIdentityCard:(NSString *)code {
    NSString *idNumberRegex = @"^(\\d{17})(\\d|[xX])$";//正则判断idNumber是17位数字加1位数字校验码或大小写xX
    NSPredicate *idNumberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idNumberRegex];
    return [idNumberPredicate evaluateWithObject:code];
}

- (BOOL)ff_verifyForPhone:(NSString *)phone {
    return [self ff_verifyForMobile:phone] || [self ff_verifyForHomePhone:phone];
}

- (BOOL)ff_verifyForMobile:(NSString *)mobile {
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|7[1-35-8]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
}

- (BOOL)ff_verifyForHomePhone:(NSString *)phone {
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * FT = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", FT];
    return [regextestcm evaluateWithObject:phone];
}

- (BOOL)ff_verifyForCarNo:(NSString *)carNo {
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

- (BOOL)ff_verifyForEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate*emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



@end
