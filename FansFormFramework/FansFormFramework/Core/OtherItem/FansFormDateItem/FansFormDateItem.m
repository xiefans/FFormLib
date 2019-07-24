//
//  FansFormDateItem.m
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormDateItem.h"

@interface FansFormDateItem ()

@property (nonatomic, strong) FansFormDateItemView *itemView;

@end

@implementation FansFormDateItem

#pragma mark - Overrides
- (FansFormDateItemView *)contentView {
    return self.itemView;
}

- (NSDate *)content {
    return self.itemView.datePickerView.date;
}

- (void)setContent:(NSDate *)content {
    [super setContent:content];
    [self.itemView.datePickerView setDate:content];
}

- (void)setValue:(NSDate *)value {
    [self setContent:value];
}

- (id)value {
    [super setValue:self.itemView.datePickerView.date];
    
    return [super value];
}

#pragma mark - Public Method
+ (instancetype)itemWithTitle:(NSString *)title
                          key:(NSString *)key
             handleValueBlock:(FansFormItemHandleValueBlock)handleValueBlock {
    return [[self alloc] initWithTitle:title
                                   key:key
                      handleValueBlock:handleValueBlock];
}
#pragma mark - Private Method
- (instancetype)initWithTitle:(NSString *)title
                          key:(NSString *)key
             handleValueBlock:(FansFormItemHandleValueBlock)handleValueBlock {
    
    if (self = [super initWithKey:key]) {
        self.title = title;
        self.handleValueBlock = handleValueBlock;
    }
    
    return self;
}

#pragma mark - Lazy Load
- (FansFormDateItemView *)itemView {
    if (!_itemView) {
        _itemView = [FansFormDateItemView new];
    }
    return _itemView;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    self.itemView.titleLb.text = title;
}

@end
