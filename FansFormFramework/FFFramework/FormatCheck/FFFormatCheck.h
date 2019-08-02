//
//  FFFormatCheck.h
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFFormatCheck : NSObject

- (NSString *)messageWithTitle:(NSString *)title;

- (BOOL)formatCheckWithString:(NSString *)string;

@end
