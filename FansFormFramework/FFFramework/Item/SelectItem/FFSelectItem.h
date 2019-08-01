//
//  FFSelectView.h
//  FansFormFramework
//
//  Created by fans on 2019/8/1.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFActionView.h"

@interface FFSelectItem : FFActionView

+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                 instructionImage:(UIImage *)instructionImage
                    numberOfLines:(NSInteger)numberOfLines
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction;

+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                    numberOfLines:(NSInteger)numberOfLines
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction;

+ (instancetype)formViewWithTitle:(NSString *)title
                      placeholder:(NSString *)placeholder
                              key:(NSString *)key
                        didAction:(FFActionViewDidAction)didAction;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *placeholderLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *instructionImageView;

@end
