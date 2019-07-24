//
//  FansFormDateItemView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormDateItemView.h"
#import "FansFormTool.h"
#import "FansFormItemConstant.h"

@implementation FansFormDateItemView

@synthesize titleLb = _titleLb;
@synthesize datePickerView = _datePickerView;
@synthesize lineView = _lineView;

#pragma mark - Overrides
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.titleLb];
        [self addSubview:self.lineView];
        [self addSubview:self.datePickerView];
        
        
        self.fans_size = CGSizeMake(FansFormItemNormalWidth, 200.f);
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat gap = 3.f;
    [self.titleLb sizeToFit];
    self.titleLb.frame = CGRectMake(
                                    FansFormItemHorizontalNormalGap,
                                    gap,
                                    FansFormItemTitleNormalWidth,
                                    self.titleLb.fans_height
                                    );
    
    self.titleLb.fans_centerY = (FansFormItemNormalHeight + gap)/ 2.f;
    
    self.datePickerView.frame = CGRectMake(
                                     self.titleLb.fans_x,
                                     self.titleLb.fans_bottom + self.titleLb.fans_y,
                                     self.fans_width,
                                     MAX(self.fans_height - self.titleLb.fans_y * 2, 0.f)
                                     );
    CGFloat lineWidth = 0.5f;
    self.lineView.frame = CGRectMake(
                                     0.f,
                                     self.fans_height - lineWidth,
                                     self.fans_width,
                                     lineWidth
                                     );
    
}


#pragma mark - Lazy Load
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FansFormItemTitleNoramlColor];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
    }
    return _titleLb;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemLineNoramlColor];
    }
    return _lineView;
}

- (UIDatePicker *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] init];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _datePickerView;
}

@end
