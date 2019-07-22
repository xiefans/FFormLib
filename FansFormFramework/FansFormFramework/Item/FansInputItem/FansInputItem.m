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
@property (nonatomic, copy) NSString *key;

@end

@implementation FansInputItem
@synthesize refreshBlock = _refreshBlock;
@synthesize getSizeBlock = _getSizeBlock;
@synthesize must = _must;
@synthesize title = _title;

#pragma mark - Public Method
+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                    sizeBlock:(FansFormItemGetSizeBlock)sizeBlock {
    return [self itemWithTitle:title
                   placeholder:placeholder
                        forKey:key
                  keyboradType:UIKeyboardTypeDefault
                     sizeBlock:sizeBlock];
}

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key {
    return [self itemWithTitle:title
                   placeholder:placeholder
                        forKey:key
                     sizeBlock:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                    sizeBlock:(FansFormItemGetSizeBlock)sizeBlock {
    return [[self alloc] initWithTitle:title
                           placeholder:placeholder
                                forKey:key
                          keyboradType:keyboradType
                             sizeBlock:sizeBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                       forKey:(NSString *)key
                 keyboradType:(UIKeyboardType)keyboradType
                    sizeBlock:(FansFormItemGetSizeBlock)sizeBlock {
    if (self = [super init]) {
        self.inputView.textField.keyboardType = keyboradType;
        self.inputView.titleLb.text = title;
        self.inputView.textField.placeholder = placeholder;
        _title = title;
        self.key = key;
        _getSizeBlock = sizeBlock;
    }
    return self;
}

- (instancetype)changeToMust {
    
    NSString *title = self.inputView.titleLb.text;
    self.inputView.titleLb.attributedText = [title beforeJoinRedStar];
    _must = YES;
    
    return self;
}

#pragma mark - Protocol
#pragma mark <FansFormItemInterface>
- (NSString *)title {
    return _title;
}

- (UIView *)contentView {
    return self.inputView;
}

- (void)setRequestContent:(NSString *)requestContent {
    [self setShowContent:requestContent];
}

- (NSString *)requestContent {
    return self.showContent;
}

- (void)setShowContent:(NSString *)content {
    self.inputView.textField.text = content;
}

- (NSString *)showContent {
    return self.inputView.textField.text;
}

- (NSString *)key {
    return _key;
}

- (void)addParam:(id)param key:(NSString *)key {
    
}

- (NSDictionary *)params {
    return nil;
}

- (void)edit {
    self.inputView.backgroundColor = [UIColor whiteColor];
    self.inputView.userInteractionEnabled = YES;
}

- (void)noEdit {
    self.inputView.userInteractionEnabled = NO;
    [self.inputView.textField resignFirstResponder];
    self.inputView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemNoEditNoramlColor];
}

- (BOOL)isEdit {
    return self.inputView.userInteractionEnabled;
}

- (void)show {
    self.inputView.show = YES;
    
    self.refreshBlock(self);
}

- (void)hide {
    self.inputView.show = NO;
    
    self.refreshBlock(self);
}

- (BOOL)isShow {
    return self.inputView.isShow;
}

- (void)setMust:(BOOL)must {
    _must = must;
    
    if (must) {
        [self changeToMust];
    } else {
        self.inputView.titleLb.text = _title;
    }
}

#pragma mark - Lazy Load

- (FansInputView *)inputView {
    if (!_inputView) {
        _inputView = [[FansInputView alloc] init];
    }
    return _inputView;
}

@end
