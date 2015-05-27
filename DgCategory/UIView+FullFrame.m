//
//  UIView+FullFrame.m
//  DgProject
//
//  Created by angela on 14-8-26.
//  Copyright (c) 2014年 angela. All rights reserved.
//

#import "UIView+FullFrame.h"

@implementation UIView (FullFrame)

#pragma mark -getter
- (CGFloat)dgLeft
{
    return self.frame.origin.x;
}

- (CGFloat)dgRight
{
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)dgWidth
{
    return self.frame.size.width;
}

- (CGFloat)dgHeight
{
    return self.frame.size.height;
}

- (CGFloat)dgTop
{
    return self.frame.origin.y;
}

- (CGFloat)dgBottom
{
    return self.frame.origin.y+self.frame.size.height;
}

- (NSDictionary *)dgFrame
{
    NSString *originalX= [NSString stringWithFormat:@"%.2f",self.frame.origin.x];
    NSString *originalY= [NSString stringWithFormat:@"%.2f",self.frame.origin.y];
    NSString *sizeW= [NSString stringWithFormat:@"%.2f",self.frame.size.width];
    NSString *sizeH= [NSString stringWithFormat:@"%.2f",self.frame.size.height];
    NSDictionary *tempDic=[[NSDictionary alloc] initWithObjectsAndKeys:originalX,@"originalx",originalY,@"originaly",sizeW,@"sizeWidth",sizeH,@"sizeHeight", nil];
    return tempDic;
}

#pragma mark -setter
- (void)setDgLeft:(CGFloat)dgLeft
{
    CGRect tempFrame=self.frame;
    tempFrame.origin.x=dgLeft;
    self.frame=tempFrame;
}

- (void)setDgRight:(CGFloat)dgRight
{
    
}

- (void)setDgWidth:(CGFloat)dgWidth{
  
}

- (void)setDgHeight:(CGFloat)dgHeight{
  
}

- (void)setDgTop:(CGFloat)dgTop
{
    CGRect tempFrame=self.frame;
    tempFrame.origin.y=dgTop;
    self.frame=tempFrame;
}

- (void)setDgBottom:(CGFloat)dgBottom
{

}

- (void)setDgFrame:(NSDictionary *)dgFrame
{

}
@end
