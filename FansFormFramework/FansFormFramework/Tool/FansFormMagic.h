//
//  FansFormMagic.h
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormContainerManager.h"
#import "FansFormView.h"


void FansMagicWillGetValue(FansFormView *formView, FansFormViewManagerWillGetValue willGetValue);

void FansMagicDidAction(FansFormView *formView, FansFormViewManagerBlock didAction);

__kindof FansFormViewManager * FansMagicCheckMust(FansFormContainerManager *manager);



