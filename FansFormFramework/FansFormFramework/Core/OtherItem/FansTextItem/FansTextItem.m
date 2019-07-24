//
//  FansTextItem.m
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansTextItem.h"

@interface FansTextItem ()

@property (nonatomic, strong) FansTextItemView *itemView;

@end

@implementation FansTextItem

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
        self.itemView.textView.keyboardType = keyboradType;
        self.itemView.titleLb.text = title;
        self.itemView.placeholderLb.text = placeholder;
        self.title = title;
        self.key = key;
        self.configBlock = configBlock;
    }
    return self;
}

#pragma mark - Protocol
#pragma mark <FansFormItemInterface>

- (UIView *)contentView {
    return self.itemView;
}

- (void)setValue:(NSString *)value {
    self.content = value;
}

- (NSString *)value {
    return self.content;
}

- (void)setContent:(NSString *)content {
    self.itemView.textView.text = content;
    [self.itemView checkContent:content];
}

- (NSString *)content {
    return self.itemView.textView.text.length != 0 ? self.itemView.textView.text : nil;
}

- (void)setEdit:(BOOL)edit {
    [super setEdit:edit];
    
    if (edit) {
        self.itemView.backgroundColor = [UIColor whiteColor];
        self.itemView.userInteractionEnabled = YES;
    } else {
        self.itemView.userInteractionEnabled = NO;
        [self.itemView.textView resignFirstResponder];
        self.itemView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemNoEditNoramlColor];
    }
}

- (void)setMust:(BOOL)must {
    [super setMust:must];
    
    if (must) {
        NSString *title = self.itemView.titleLb.text;
        self.itemView.titleLb.attributedText = [title beforeJoinRedStar];
    } else {
        self.itemView.titleLb.text = self.title;
    }
}

- (FansFormAbstractItem *)itemForKey:(NSString *)key {
    return self;
}

#pragma mark - Lazy Load

- (FansTextItemView *)itemView {
    if (!_itemView) {
        _itemView = [[FansTextItemView alloc] init];
    }
    return _itemView;
}

@end
