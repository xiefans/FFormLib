## FFFramework

1. AutoHeightContainerItem 添加 AutoHeightInputItem 时。 AutoHeightInputItem 自动刷新自身的高度时， AutoHeightContainerItem的高度变化了，但是没有通知到最外层的ScrollContainerItem。
   - 原因：AutoHeightContainerItem的高度计算是单独的方法，计算的同时布局完成的。子item触发了layoutsubviews方法，但是并没有刷新自身高度。
   
   - 解决方法：在子item发出刷新信号的时候，调用refreshSize方法，刷新自身高度
   
   - ```objective-c
     [obj.manager setRefreshBlock:^(FFViewManager *manager) {
                 __strong typeof(weakSelf)self = weakSelf;
                 [self ff_refreshSize];
                 [self setNeedsLayout];
                 [self layoutIfNeeded];
             }];
     ```
   
     