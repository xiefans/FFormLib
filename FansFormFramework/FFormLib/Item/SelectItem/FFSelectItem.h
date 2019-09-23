//
//  FFSelectView.h
//  FansFormFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFActionView.h"

@interface FFSelectItem : FFActionView

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
               instructionImage:(UIImage *)instructionImage
                  numberOfLines:(NSInteger)numberOfLines
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction;

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                  numberOfLines:(NSInteger)numberOfLines
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction;

+ (instancetype)actionWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must
                            key:(NSString *)key
                      didAction:(FFActionViewDidAction)didAction;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *placeholderLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *instructionImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *mustLb;

/** 标题和输入框之间的距离(不设置是默认间距) */
@property (nonatomic, assign)CGFloat titleToInputGap;
/** 标题的宽度(不设置是默认宽度) */
@property (nonatomic, assign)CGFloat titleWidth;

@end
