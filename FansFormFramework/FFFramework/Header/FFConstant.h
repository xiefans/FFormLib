//
//  FFConstant.h
//  FFFramework
//
//  Created by 谢帆 on 2019/7/27.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#ifndef FFConstant_h
#define FFConstant_h

// 所有自带的item都使用如下定义

static CGFloat const FFViewNormalGap = 10.f; /**< 默认间隔 */
static CGFloat const FFViewNormalHeight = 55.0f; /**< 默认高度 */

static CGFloat const FFViewTitleNormalWidth = 90.f; /**< 标题默认宽度 */
static CGFloat const FFViewTitleNormalFontSize = 15.f; /**< 标题字体默认大小 */
static unsigned const FFViewTitleNormalTextColor = 0x666666; /**< 标题字体默认颜色 */

static CGFloat const FFViewContentNormalFontSize = 14.f; /**< 展示内容字体默认大小 */
static unsigned const FFViewContentNormalTextColor = 0x333333; /**< 展示内容字体默认颜色 */
static unsigned const FFViewPlaceholderNormalTextColor = 0xD3D3D3; /**< 提示文字默认颜色 */

static unsigned const FFViewLineViewNormalColor = 0xEEEEEE; /**< 间隔线默认颜色 */
static CGFloat const FFViewLineNormalHeight = 0.5f; /**< 间隔线默认高度 */

static CGFloat const FFViewFixHeightNormalHeight = 150.f; /**< 固定高度（一般指高度比一般视图要高的）默认高度 */

static CGFloat const FFViewMustRedFormTitleGap = 5.f; /**< 必填标记距离标题的距离 */


#define FFContainerViewNormalPadding \
(UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f))

#define FFItemViewNormalPadding \
(UIEdgeInsetsMake(5.f, 20.f, 5.f, 15.f))

#endif /* FFConstant_h */
