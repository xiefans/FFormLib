//
//  FFSelectView.m
//  FansFormFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFSelectItem.h"
#import "FFTool.h"
@implementation FFSelectItem

- (void)dealloc {
    [self.contentLb removeObserver:self forKeyPath:@"text"];
}

+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction {
    return [self formViewWithTitle:title
                       placeholder:placeholder
                  instructionImage:nil
                               key:key
                         didAction:didAction];
}


+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                 instructionImage:(UIImage *)instructionImage
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction {
    
    return [self formViewWithTitle:title
                       placeholder:placeholder
                  instructionImage:instructionImage
                     numberOfLines:0
                               key:key
                         didAction:didAction];
}

+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                 instructionImage:(UIImage *)instructionImage
                    numberOfLines:(NSInteger)numberOfLines
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction {
    FFSelectItem *selectView = [[FFSelectItem alloc] initWithKey:key];
    selectView.titleLb.text = title;
    selectView.placeholderLb.text = placeholder;
    selectView.instructionImageView.image = instructionImage;
    selectView.contentLb.numberOfLines = numberOfLines;
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
        
        [self.contentLb addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
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
    
    CGFloat height = self.contentLb.fans_height;
    [self.contentLb sizeToFit];
    if (height != self.contentLb.fans_height) {
        self.size = CGSizeMake(
                               self.size.width,
                               self.contentLb.fans_height + self.paddingInsets.top + self.paddingInsets.bottom
                               );
        [self.manager excuteRefreshBlock];
    }
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont boldSystemFontOfSize:FFViewTitleNormalFontSize];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FFViewTitleNormalTextColor];
    }
    return _titleLb;
}

- (UILabel *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UILabel alloc] init];
        _placeholderLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _placeholderLb.textColor = [UIColor fans_colorWithHexValue:FFViewPlaceholderNormalTextColor];
    }
    return _placeholderLb;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _contentLb.textColor = [UIColor fans_colorWithHexValue:FFViewContentNormalTextColor];
    }
    return _contentLb;
}

- (UIImageView *)instructionImageView {
    if (!_instructionImageView) {
        _instructionImageView = [[UIImageView alloc] init];
    }
    return _instructionImageView;
}

@end
