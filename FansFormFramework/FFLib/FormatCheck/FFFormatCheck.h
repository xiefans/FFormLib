//
//  FFFormatCheck.h
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFFormatCheck : NSObject

/**
 根据title 拼接 提示文字

 @param title title
 @return 提示文字
 */
- (NSString *)messageWithTitle:(NSString *)title;

/**
 检查string 是否符合 规则

 @param string string
 @return 是否符合
 */
- (BOOL)formatCheckWithString:(NSString *)string;

@end
