//
//  NSString+FansAttributed.m
//  FFFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "NSString+FansAttributed.h"
#import <UIKit/UIKit.h>

@implementation NSString (FansAttributed)

- (NSAttributedString *)beforeJoinRedStar {
    
    NSString *target = @"*";
    
    NSMutableAttributedString *attString =
        [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",target,self]];
    
    [attString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:[attString.string rangeOfString:target]];
    return attString;
}

- (NSAttributedString *)afterJoinRedStar {
    NSString *target = @"*";
    
    NSMutableAttributedString *attString =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",self,target]];
    
    [attString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:[attString.string rangeOfString:target]];
    return attString;
}

@end
