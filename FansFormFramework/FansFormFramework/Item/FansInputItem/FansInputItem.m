//
//  FansInputItem.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansInputItem.h"
#import "FansInputView.h"
@interface FansInputItem ()

@property (nonatomic, strong) FansInputView *inputView;
@property (nonatomic, copy) NSString *key;

@end

@implementation FansInputItem
@synthesize refreshBlock = _refreshBlock;

#pragma mark - Public Method
+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder forKey:(NSString *)key {
    return [[self alloc] initWithTitle:title placeholder:placeholder forKey:key];
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder forKey:(NSString *)key {
    if (self = [super init]) {
        self.inputView.titleLb.text = title;
        self.key = key;
    }
    return self;
}


#pragma mark - Protocol
#pragma mark <FansFormItemInterface>
- (UIView<FansFormItemViewInterface> *)contentView {
    return self.inputView;
}

- (void)setRequestContent:(NSString *)requestContent {
    [self setShowContent:requestContent];
}

- (NSString *)requestContent {
    return self.showContent;
}

- (void)setShowContent:(NSString *)content {
    self.inputView.textView.text = content;
}

- (NSString *)showContent {
    return self.inputView.textView.text;
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
    self.inputView.backgroundColor = [UIColor clearColor];
    self.inputView.userInteractionEnabled = YES;
}

- (void)noEdit {
    self.inputView.userInteractionEnabled = NO;
    [self.inputView.textView resignFirstResponder];
    self.inputView.backgroundColor = [UIColor lightGrayColor];
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

#pragma mark - Lazy Load

- (FansInputView *)inputView {
    if (!_inputView) {
        _inputView = [[FansInputView alloc] init];
    }
    return _inputView;
}

@end
