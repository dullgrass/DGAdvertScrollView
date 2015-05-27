//
//  UIView+FullFrame.h
//  DgProject
//
//  Created by angela on 14-8-26.
//  Copyright (c) 2014年 angela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FullFrame)

@property (nonatomic) CGFloat dgLeft;     //!< 左x坐标
@property (nonatomic) CGFloat dgRight;    //!< 右x坐标
@property (nonatomic) CGFloat dgWidth;    //!< 宽度
@property (nonatomic) CGFloat dgHeight;   //!< 高度
@property (nonatomic) CGFloat dgTop;      //!< 上面的y坐标
@property (nonatomic) CGFloat dgBottom;   //!< 底部的y坐标

@property (nonatomic,strong) NSDictionary *dgFrame;   //!< 返回self的frame

@end
