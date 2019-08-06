//
//  FFResourceSupport.m
//  FansFormFramework
//
//  Created by fans on 2019/8/6.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFResourceSupport.h"
#import "FFResourceName.h"
@implementation FFResourceSupport

+ (UIImage *)imageWithName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"FFResourceImage" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIImage *)blackRightArrowSmallImage {
    return [self imageWithName:IMGFFSelectItemNormalInstructionImage];
}

@end
