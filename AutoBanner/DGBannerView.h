//
//  DGBannerView.h
//  DgShopModel
//
//  Created by dullgrass on 15/5/21.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DGBannerModal.h"

typedef void (^ClickImageBlock) (NSInteger imageID);

@interface DGBannerView : UIView

@property (nonatomic , strong) UIColor *pageOnColor;           //!< 选中的pageControl的颜色
@property (nonatomic , strong) UIColor *pageOffColor;          //!< 非选中pageCOntrol的颜色

@property (nonatomic , assign) CGFloat animationTime;          //!< 动画持续时间
@property (nonatomic , assign) CGFloat animationWaitingTime;   //!< 画面静止时间

@property (nonatomic , strong) NSArray *bannerArray;           //!< 用于显示的图片和名称数据

@property (nonatomic , strong) ClickImageBlock clickImageBlock; //!< 用户点击当前图片

@end
