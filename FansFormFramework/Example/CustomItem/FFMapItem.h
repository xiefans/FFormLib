//
//  FFMapItem.h
//  FansFormFramework
//
//  Created by fans on 2019/9/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"
#import "FFMultipleParametersManager.h"
/**
 latitudeKey  默认 latitude
 longitudeKey  默认 longitude
 */
@interface FFMapItem : FFView

+ (instancetype)mapWithKey:(NSString *)key;
+ (instancetype)mapWithLongitudeKey:(NSString *)longitudeKey
                        latitudeKey:(NSString *)latitudeKey
                                key:(NSString *)key;

- (__kindof FFMultipleParametersManager *)manager;

@property (nonatomic, copy, readonly) NSString *longitudeKey;
@property (nonatomic, copy, readonly) NSString *latitudeKey;

- (void)test;

@end
