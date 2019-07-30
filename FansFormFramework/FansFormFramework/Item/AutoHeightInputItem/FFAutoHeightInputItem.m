//
//  FasnFormAHInputItem.m
//  FansFormFramework
//
//  Created by 谢帆 on 2019/7/28.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFAutoHeightInputItem.h"
#import "FansFormTool.h"

@interface FFAutoHeightInputItem () <UITextViewDelegate>

@end

@implementation FFAutoHeightInputItem

@synthesize titleLb = _titleLb;
@synthesize placeholderLb = _placeholderLb;
@synthesize textView = _textView;
@synthesize lineView = _lineView;
@synthesize titleToInputGap = _titleToInputGap;
@synthesize titleWidth = _titleWidth;
@synthesize mustLb = _mustLb;

+ (instancetype)formViewWithKey:(NSString *)key
                          title:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must {
    FFAutoHeightInputItem *item = [self formViewWithKey:key];
    item.manager.title = title;
    item.placeholderLb.text = placeholder;
    item.manager.must = must;
    return item;
}

- (void)dealloc {
    [self removeObserver:self.textView forKeyPath:@"text"];
}

- (instancetype)initWithManager:(__kindof FansFormViewManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        self.paddingInsets = FansFormItemViewNormalPadding;
        __weak typeof(self)sself = self;
        [manager setDidSetContent:^(FansFormViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            self.textView.text = content;
        }];
        
        [manager setWillGetContent:^id(FansFormViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            return self.textView.text.length == 0 ? nil : self.textView.text;
        }];
        
        [manager setWillGetValue:^id(FansFormViewManager *manager, id value) {
            return manager.content;
        }];
        
        [manager setDidSetTitle:^(FansFormViewManager *manager, NSString *title) {
            __strong typeof(sself)self = sself;
            self.titleLb.text = title;
        }];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.textView];
        [self addSubview:self.placeholderLb];
        [self addSubview:self.lineView];
        [self addSubview:self.mustLb];
        
        [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(
                                    self.paddingInsets.left,
                                    self.paddingInsets.top,
                                    self.titleWidth,
                                    MIN(FansFormViewNormalHeight, self.fans_height) - self.paddingInsets.top - self.paddingInsets.bottom
                                    );
    CGPoint center = self.titleLb.center;
    [self.titleLb sizeToFit];
    self.titleLb.fans_centerY = center.y;
    self.titleLb.fans_width = self.titleWidth;
    
    CGFloat x = self.titleLb.fans_right + self.titleToInputGap;
    self.textView.frame = CGRectMake(
                                      x,
                                      self.titleLb.fans_y,
                                      self.fans_width - x - self.paddingInsets.right,
                                      MAX(self.fans_height - (self.titleLb.fans_y * 2.f - self.paddingInsets.top + self.paddingInsets.bottom), 0.f)
                                      );
    self.placeholderLb.frame = self.textView.frame;
    self.lineView.frame = CGRectMake(
                                     self.titleLb.fans_x,
                                     self.fans_height - FansFormViewLineNormalHeight,
                                     self.textView.fans_right - self.titleLb.fans_left,
                                     FansFormViewLineNormalHeight
                                     );
    
    [self.mustLb sizeToFit];
    self.mustLb.fans_origin = CGPointMake(self.titleLb.fans_x - self.mustLb.fans_width - FansFormViewMustRedFormTitleGap, 0.f);
    self.mustLb.fans_centerY = self.titleLb.fans_centerY;
}

- (void)changeMust:(BOOL)isMust {
    
    self.mustLb.hidden = !isMust;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.textView sizeToFit];
    
    CGFloat height = self.fans_height;
    self.fans_height = (self.titleLb.fans_y * 2.f - self.paddingInsets.top + self.paddingInsets.bottom) + self.textView.fans_height;
    if (height != self.fans_height) {
        [self.manager excuteRefreshBlock];
    }
    
    NSString *content = textView.text;
    if (content.length == 0) {
        self.placeholderLb.hidden = NO;
    } else {
        self.placeholderLb.hidden = YES;
    }
}

- (CGSize)size {
    return CGSizeMake(0.f, self.fans_height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if (object == self.textView && [keyPath isEqualToString:@"text"]) {
        
        NSString *content = change[NSKeyValueChangeNewKey];
        if (content.length == 0) {
            self.placeholderLb.hidden = NO;
        } else {
            self.placeholderLb.hidden = YES;
        }
        CGSize size = [content boundingRectWithSize:CGSizeMake(self.textView.fans_width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : self.textView.font}
                                            context:nil].size;
        CGFloat height = self.fans_height;
        self.fans_height = (self.titleLb.fans_y * 2.f - self.paddingInsets.top + self.paddingInsets.bottom) + size.height;
        if (height != self.fans_height) {
            [self.manager excuteRefreshBlock];
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(self.textView.fans_x, 0, self.textView.fans_width, self.fans_height), point)) {
        return self.textView;
    }
    return nil;
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
    return FansFormViewNormalGap;
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
    return FansFormViewTitleNormalWidth;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:FansFormViewTitleNormalFontSize];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FansFormViewTitleNormalTextColor];
    }
    return _titleLb;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor fans_colorWithHexValue:FansFormViewContentNormalTextColor];
        _textView.font = [UIFont systemFontOfSize:FansFormViewContentNormalFontSize];
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
    }
    return _textView;
}

- (UITextView *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UITextView alloc] init];
        _placeholderLb.font = [UIFont systemFontOfSize:FansFormViewContentNormalFontSize];
        _placeholderLb.textColor = [UIColor fans_colorWithHexValue:FansFormViewPlaceholderNormalTextColor];
        _placeholderLb.contentInset = UIEdgeInsetsZero;
        _placeholderLb.textContainerInset = UIEdgeInsetsZero;
        _placeholderLb.editable = NO;
        _placeholderLb.backgroundColor = [UIColor clearColor];
        _placeholderLb.textContainer.lineFragmentPadding = 0;
    }
    return _placeholderLb;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormViewLineViewNormalColor];
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
