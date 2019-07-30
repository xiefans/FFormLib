//
//  FansFormConstant.h
//  FansFormFramework
//
//  Created by 谢帆 on 2019/7/27.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#ifndef FansFormConstant_h
#define FansFormConstant_h

// 所有自带的item都使用如下定义

static CGFloat const FansFormViewNormalGap = 10.f; /**< 默认间隔 */
static CGFloat const FansFormViewNormalHeight = 55.0f; /**< 默认高度 */

static CGFloat const FansFormViewTitleNormalWidth = 90.f; /**< 标题默认宽度 */
static CGFloat const FansFormViewTitleNormalFontSize = 15.f; /**< 标题字体默认大小 */
static unsigned const FansFormViewTitleNormalTextColor = 0x666666; /**< 标题字体默认颜色 */

static CGFloat const FansFormViewContentNormalFontSize = 14.f; /**< 展示内容字体默认大小 */
static unsigned const FansFormViewContentNormalTextColor = 0x333333; /**< 展示内容字体默认颜色 */
static unsigned const FansFormViewPlaceholderNormalTextColor = 0xD3D3D3; /**< 提示文字默认颜色 */

static unsigned const FansFormViewLineViewNormalColor = 0xEEEEEE; /**< 间隔线默认颜色 */
static CGFloat const FansFormViewLineNormalHeight = 0.5f; /**< 间隔线默认高度 */

static CGFloat const FansFormViewFixHeightNormalHeight = 150.f; /**< 固定高度（一般指高度比一般视图要高的）默认高度 */

static CGFloat const FansFormViewMustRedFormTitleGap = 5.f; /**< 必填标记距离标题的距离 */


#define FansFormContainerViewNormalPadding \
(UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f))

#define FansFormItemViewNormalPadding \
(UIEdgeInsetsMake(5.f, 20.f, 5.f, 15.f))

#endif /* FansFormConstant_h */
