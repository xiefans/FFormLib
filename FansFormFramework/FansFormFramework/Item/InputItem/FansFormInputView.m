//
//  FansFormInputView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormInputView.h"
#import "FansFormTool.h"
@implementation FansFormInputView

@synthesize titleLb = _titleLb;
@synthesize textField = _textField;
@synthesize lineView = _lineView;

+ (instancetype)formViewWithKey:(NSString *)key must:(BOOL)must {
    return [self formViewWithKey:key title:nil placeholder:nil must:must];
}

+ (instancetype)formViewWithKey:(NSString *)key
                          title:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must {
    FansFormInputView *view = [FansFormInputView formViewWithKey:key];
    view.must = must;
    view.titleLb.text = title;
    view.textField.placeholder = placeholder;
    return view;
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FansInputViewManager managerWithKey:key]];
}

- (instancetype)initWithManager:(__kindof FansFormViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        
        __weak typeof(self)sself = self;
        [manager setDidSetContent:^(FansFormViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            
            self.textField.text = content;
        }];
        
        [manager setWillGetContent:^id(FansFormViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            
            content = self.textField.text.length > 0 ? self.textField.text : nil;
            
            return content;
        }];
        
        [manager setDidSetTitle:^(FansFormViewManager *manager, NSString *title) {
            __strong typeof(sself)self = sself;
            
            self.titleLb.text = title;
        }];
        
        [manager setWillGetValue:^id(FansFormViewManager *manager, id value) {
            return manager.content;
        }];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(
                                    self.paddingInsets.left,
                                    self.paddingInsets.top,
                                    self.titleWidth,
                                    MAX(self.fans_height - self.paddingInsets.top - self.paddingInsets.bottom, 0.f)
                                    );
    
    CGFloat x = self.titleLb.fans_right + self.titleToInputGap;
    self.textField.frame = CGRectMake(
                                      x,
                                      self.titleLb.fans_y,
                                      self.fans_width - x - self.paddingInsets.right,
                                      self.titleLb.fans_height
                                      );
    
    self.lineView.frame = CGRectMake(
                                     self.titleLb.fans_x,
                                     self.fans_height - FansFormViewLineNormalHeight,
                                     self.textField.fans_right - self.titleLb.fans_left,
                                     FansFormViewLineNormalHeight
                                     );
}

- (CGFloat)titleToInputGap {
    if (_titleToInputGap) {
        return _titleToInputGap;
    }
    return FansFormViewNormalGap;
}

- (CGFloat)titleWidth {
    if (_titleWidth) {
        return _titleWidth;
    }
    return FansFormViewTitleNormalWidth;
}


- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
    }
    return _titleLb;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:0xEEEEEE];
    }
    return _lineView;
}


@end
