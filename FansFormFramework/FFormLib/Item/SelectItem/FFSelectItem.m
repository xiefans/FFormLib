//
//  FFSelectView.m
//  FansFormFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFSelectItem.h"
#import "FFTool.h"
#import "FFResourceName.h"
@implementation FFSelectItem


@synthesize titleToInputGap = _titleToInputGap;
@synthesize titleWidth = _titleWidth;

- (void)dealloc {
    [self.contentLb removeObserver:self forKeyPath:@"text"];
}

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction {
    return [self actionWithTitle:title
                     placeholder:placeholder
                instructionImage:[FFResourceSupport blackRightArrowSmallImage]
                   numberOfLines:0
                            must:must
                             key:key
                       didAction:didAction];
}

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                  numberOfLines:(NSInteger)numberOfLines
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction {
    
    
    return [self actionWithTitle:title
                     placeholder:placeholder
                instructionImage:[FFResourceSupport blackRightArrowSmallImage]
                   numberOfLines:numberOfLines
                            must:must
                             key:key
                       didAction:didAction];
}

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
               instructionImage:(UIImage *)instructionImage
                  numberOfLines:(NSInteger)numberOfLines
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction {
    FFSelectItem *selectView = [[FFSelectItem alloc] initWithKey:key];
    selectView.manager.title = title;
    selectView.placeholderLb.text = placeholder;
    selectView.instructionImageView.image = instructionImage;
    selectView.contentLb.numberOfLines = numberOfLines;
    selectView.manager.must = must;
    __weak typeof(selectView)sself = selectView;
    [selectView.manager setDidAction:^(FFViewManager *manager) {
        if (didAction) {
            didAction(sself);
        }
    }];
    
    return selectView;
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        
        self.paddingInsets = FFItemViewNormalPadding;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.manager
                                                                           action:@selector(excuteDidAction)]];
        
        __weak typeof(self)sself = self;
        [manager setDidSetTitle:^(FFViewManager *manager, NSString *title) {
            sself.titleLb.text = title;
        }];
        
        [manager setDidSetContent:^(FFViewManager *manager, id content) {
            sself.contentLb.text = content;
        }];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.placeholderLb];
        [self addSubview:self.contentLb];
        [self addSubview:self.instructionImageView];
        [self addSubview:self.mustLb];
        [self addSubview:self.lineView];
        
        [self.contentLb addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(
                                    self.paddingInsets.left,
                                    self.paddingInsets.top,
                                    self.titleWidth,
                                    MIN(FFViewNormalHeight, self.ff_height) - self.paddingInsets.top - self.paddingInsets.bottom
                                    );
    CGPoint center = self.titleLb.center;
    [self.titleLb sizeToFit];
    self.titleLb.ff_centerY = center.y;
    self.titleLb.ff_width = self.titleWidth;
    
    CGFloat x = self.titleLb.ff_right + self.titleToInputGap;
    CGFloat contentWidth = self.ff_width - x - self.paddingInsets.right;
    
    if (self.instructionImageView.image) {
        self.instructionImageView.frame = CGRectMake(
                                                     self.ff_width - self.paddingInsets.right - self.instructionImageView.ff_width,
                                                     0.f,
                                                     self.instructionImageView.ff_width,
                                                     self.instructionImageView.ff_height
                                                     );
        contentWidth = self.instructionImageView.ff_x - FFViewNormalGap - x;
    } else {
        self.instructionImageView.frame = CGRectMake(0.f, 0.f, 0.f, 0.f);
    }
    self.instructionImageView.ff_centerY = self.ff_halfHeight;
    
    self.contentLb.frame = CGRectMake(
                                     x,
                                     self.titleLb.ff_y,
                                     contentWidth,
                                     MAX(self.ff_height - (self.titleLb.ff_y * 2 - self.paddingInsets.top + self.paddingInsets.bottom), 0.f)
                                     );
    
    self.placeholderLb.frame = self.contentLb.frame;
    self.lineView.frame = CGRectMake(
                                     self.titleLb.ff_x,
                                     self.ff_height - FFViewLineNormalHeight,
                                     self.ff_right - self.titleLb.ff_left - self.paddingInsets.right,
                                     FFViewLineNormalHeight
                                     );
    
    [self.mustLb sizeToFit];
    self.mustLb.ff_origin = CGPointMake(self.titleLb.ff_x - self.mustLb.ff_width - FFViewMustRedFormTitleGap, 0.f);
    self.mustLb.ff_centerY = self.titleLb.ff_centerY;
}

- (void)changeMust:(BOOL)isMust {
    self.mustLb.hidden = !isMust;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    NSString *text = change[NSKeyValueChangeNewKey];
    
    if (text && text.length > 0) {
        self.placeholderLb.hidden = YES;
    } else {
        self.placeholderLb.hidden = NO;
    }
    
    CGFloat height = self.contentLb.ff_height;
    [self.contentLb sizeToFit];
    if (height != self.contentLb.ff_height) {
        self.size = CGSizeMake(
                               self.size.width,
                               MAX(
                                   self.contentLb.ff_height +
                                   self.paddingInsets.top +
                                   self.paddingInsets.bottom +
                                   (self.titleLb.ff_y - self.paddingInsets.top) * 2.f,
                                   FFViewNormalHeight
                                   )
                               );
        [self.manager excuteRefreshBlock];
    }
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
        _titleLb.font = [UIFont systemFontOfSize:FFViewTitleNormalFontSize];
        _titleLb.textColor = [UIColor ff_colorWithHexValue:FFViewTitleNormalTextColor];
    }
    return _titleLb;
}

- (UILabel *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UILabel alloc] init];
        _placeholderLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _placeholderLb.textColor = [UIColor ff_colorWithHexValue:FFViewPlaceholderNormalTextColor];
    }
    return _placeholderLb;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _contentLb.textColor = [UIColor ff_colorWithHexValue:FFViewContentNormalTextColor];
    }
    return _contentLb;
}

- (UIImageView *)instructionImageView {
    if (!_instructionImageView) {
        _instructionImageView = [[UIImageView alloc] init];
        _instructionImageView.ff_width = FFViewSelectItemInstructionImageViewWidth;
        _instructionImageView.ff_height = FFViewSelectItemInstructionImageViewHeight;
        _instructionImageView.contentMode = UIViewContentModeScaleAspectFit;
        _instructionImageView.layer.masksToBounds = YES;
    }
    return _instructionImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor ff_colorWithHexValue:FFViewLineViewNormalColor];
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
