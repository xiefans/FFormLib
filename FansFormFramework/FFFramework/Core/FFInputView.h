//
//  FFInputView.h
//  FansFormFramework
//
//  Created by fans on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFView.h"


@class FFInputView;
typedef BOOL(^FFInputViewShouldBeginEditingBlock)(__kindof FFInputView *inputView);
typedef void(^FFInputViewDidEndEditingBlock)(__kindof FFInputView *inputView);
@interface FFInputView : FFView

@property (nonatomic, copy) FFInputViewShouldBeginEditingBlock shouldBeginEditing;
@property (nonatomic, copy) FFInputViewDidEndEditingBlock didEndEditing;

@end
