//
//  FFMagic.h
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerManager.h"
#import "FFView.h"


void FFMagicWillGetValue(FFView *formView, FFViewManagerWillGetValue willGetValue);

void FFMagicDidAction(FFView *formView, FFViewManagerBlock didAction);

__kindof FFViewManager * FansMagicCheckMust(FFContainerManager *manager);



