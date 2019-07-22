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
    
}

- (void)hide {
    
}

- (void)noEdit {
    
}

- (void)show {
    
}

#pragma mark - Lazy Load

- (FansInputView *)inputView {
    if (!_inputView) {
        _inputView = [[FansInputView alloc] init];
    }
    return _inputView;
}

@end
