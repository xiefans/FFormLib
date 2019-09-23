//
//  FFMapItem.m
//  FansFormFramework
//
//  Created by fans on 2019/9/23.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFMapItem.h"
#import "FFMultipleParametersManager.h"

static NSString * const kNormalLongitudeKey = @"longitude";
static NSString * const kNormalLatitudeKey = @"latitude";

@implementation FFMapItem

+ (instancetype)mapWithKey:(NSString *)key {
    return [self mapWithLongitudeKey:kNormalLongitudeKey latitudeKey:kNormalLatitudeKey key:key];
}

+ (instancetype)mapWithLongitudeKey:(NSString *)longitudeKey latitudeKey:(NSString *)latitudeKey key:(NSString *)key {
    FFMapItem *item = [self formViewWithKey:key];
    item->_longitudeKey = longitudeKey;
    item->_latitudeKey = latitudeKey;
    FFMultipleParametersManager *manager = item.manager;
    [manager registerKey:longitudeKey must:YES];
    [manager registerKey:latitudeKey must:YES];
    return item;
}

- (FFMultipleParametersManager *)manager {
    return [super manager];
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FFMultipleParametersManager managerWithKey:key]];
}

- (void)test {
    [self.manager setParameter:@"1.001" forKey:self.longitudeKey];
    [self.manager setParameter:@"2.003" forKey:self.latitudeKey];
}

@end
