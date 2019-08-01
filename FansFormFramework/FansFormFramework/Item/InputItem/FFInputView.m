//
//  FFInputView.m
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFInputView.h"
#import "FFTool.h"
@implementation FFInputView

@synthesize titleLb = _titleLb;
@synthesize textField = _textField;
@synthesize lineView = _lineView;
@synthesize titleToInputGap = _titleToInputGap;
@synthesize titleWidth = _titleWidth;
@synthesize mustLb = _mustLb;

+ (instancetype)formViewWithKey:(NSString *)key must:(BOOL)must {
    return [self formViewWithKey:key title:nil placeholder:nil must:must];
}

+ (instancetype)formViewWithKey:(NSString *)key
                          title:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must {
    FFInputView *view = [self formViewWithKey:key];
    view.must = must;
    view.manager.title = title;
    view.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor fans_colorWithHexValue:FFViewPlaceholderNormalTextColor]}];
    return view;
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        
        self.paddingInsets = FFItemViewNormalPadding;
        
        __weak typeof(self)sself = self;
        [manager setDidSetContent:^(FFViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            
            self.textField.text = content;
        }];
        
        [manager setWillGetContent:^id(FFViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            
            content = self.textField.text.length > 0 ? self.textField.text : nil;
            
            return content;
        }];
        
        [manager setDidSetTitle:^(FFViewManager *manager, NSString *title) {
            __strong typeof(sself)self = sself;
            
            self.titleLb.text = title;
        }];
        
        [manager setWillGetValue:^id(FFViewManager *manager, id value) {
            return manager.content;
        }];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        [self addSubview:self.mustLb];
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
                                     self.fans_height - FFViewLineNormalHeight,
                                     self.textField.fans_right - self.titleLb.fans_left,
                                     FFViewLineNormalHeight
                                     );
    
    [self.mustLb sizeToFit];
    self.mustLb.fans_origin = CGPointMake(self.titleLb.fans_x - self.mustLb.fans_width - FFViewMustRedFormTitleGap, 0.f);
    self.mustLb.fans_centerY = self.titleLb.fans_centerY;
}

- (void)changeMust:(BOOL)isMust {
    
    self.mustLb.hidden = !isMust;
}

- (void)setTitleToInputGap:(CGFloat)titleToInputGap {
    if (_titleToInputGap == titleToInputGap) {
        return;
    }
    _titleToInputGap = titleToInputGap;
    [self setNeedsLayout];
}

- (CGFloat)titleToInputGap {
    if (_titleToInputGap) {
        return _titleToInputGap;
    }
    return FFViewNormalGap;
}

- (void)setTitleWidth:(CGFloat)titleWidth {
    if (_titleWidth == titleWidth) {
        return;
    }
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}

- (CGFloat)titleWidth {
    if (_titleWidth) {
        return _titleWidth;
    }
    return FFViewTitleNormalWidth;
}


- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FFViewTitleNormalTextColor];
        _titleLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
    }
    return _titleLb;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _textField.textColor = [UIColor fans_colorWithHexValue:FFViewContentNormalTextColor];
    }
    return _textField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:FFViewLineViewNormalColor];
    }
    return _lineView;
}

- (UILabel *)mustLb {
    if (!_mustLb) {
        _mustLb = [[UILabel alloc] init];
        _mustLb.text = @"*";
        _mustLb.textColor = [UIColor redColor];
        _mustLb.hidden = YES;
    }
    return _mustLb;
}

@end
