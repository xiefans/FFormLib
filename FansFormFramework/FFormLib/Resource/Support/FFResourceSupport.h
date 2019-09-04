//
//  FFResourceSupport.h
//  FansFormFramework
//
//  Created by fans on 2019/8/6.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFResourceSupport : NSObject

/**
 获取图片

 @param imageName 图片名称
 @return 图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName;

/**
 获取黑色的右箭头 （目前使用在selectItem上的默认图）

 @return 右箭头图片
 */
+ (UIImage *)blackRightArrowSmallImage;

@end

