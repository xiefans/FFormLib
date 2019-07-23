//
//  FansInputItem.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansInputItem.h"
#import "FansFormTool.h"
#import "FansInputView.h"
#import "FansFormItemConstant.h"
@interface FansInputItem ()

@property (nonatomic, strong) FansInputView *inputView;

@end

@implementation FansInputItem

#pragma mark - Overrides
- (void)setShowSize:(CGSize)showSize {
    self.inputView.fans_size = showSize;
    self.refreshBlock(self);
}

#pragma mark - Public Method
+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                  configBlock:(FansFormItemBlock)configBlock {
    return [self itemWithTitle:title
                   placeholder:placeholder
                        forKey:key
                  keyboradType:UIKeyboardTypeDefault
                     configBlock:configBlock];
}

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key {
    return [self itemWithTitle:title
                   placeholder:placeholder
                        forKey:key
                     configBlock:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                  configBlock:(FansFormItemBlock)configBlock {
    return [[self alloc] initWithTitle:title
                           placeholder:placeholder
                                forKey:key
                          keyboradType:keyboradType
                             configBlock:configBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                  configBlock:(FansFormItemBlock)configBlock {
    if (self = [super init]) {
        self.inputView.textField.keyboardType = keyboradType;
        self.inputView.titleLb.text = title;
        self.inputView.textField.placeholder = placeholder;
        self.title = title;
        self.key = key;
        self.configBlock = configBlock;
    }
    return self;
}

- (instancetype)changeToMust {
    
    NSString *title = self.inputView.titleLb.text;
    self.inputView.titleLb.attributedText = [title beforeJoinRedStar];
    [super setMust:YES];
    
    return self;
}

#pragma mark - Protocol
#pragma mark <FansFormItemInterface>

- (UIView *)contentView {
    return self.inputView;
}

- (void)setValue:(NSString *)value {
    self.content = value;
}

- (NSString *)value {
    return self.content;
}

- (void)setContent:(NSString *)content {
    self.inputView.textField.text = content;
}

- (NSString *)content {
    return self.inputView.textField.text.length != 0 ? self.inputView.textField.text : nil;
}

- (void)setEdit:(BOOL)edit {
    [super setEdit:edit];
    
    if (edit) {
        self.inputView.backgroundColor = [UIColor whiteColor];
        self.inputView.userInteractionEnabled = YES;
    } else {
        self.inputView.userInteractionEnabled = NO;
        [self.inputView.textField resignFirstResponder];
        self.inputView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemNoEditNoramlColor];
    }
}

- (void)setMust:(BOOL)must {
    [super setMust:must];
    
    if (must) {
        [self changeToMust];
    } else {
        self.inputView.titleLb.text = self.title;
    }
}

- (FansFormAbstractItem *)itemForKey:(NSString *)key {
    return self;
}

#pragma mark - Lazy Load

- (FansInputView *)inputView {
    if (!_inputView) {
        _inputView = [[FansInputView alloc] init];
    }
    return _inputView;
}

@end
