//
//  DGImageView.m
//  DGShopClient
//
//  Created by dullgrass on 15/5/26.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import "DGImageView.h"

#define DGBanner_Title_Font [UIFont systemFontOfSize:15.f]

@implementation DGImageView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    
    [self addSubview:self.title];
  }
  return self;
}

- (instancetype)init{
  if (self = [super init]) {
    
    [self addSubview:self.title];
  }
  return self;
}

- (void)awakeFromNib{
  
  [self addSubview:self.title];
}

- (UILabel *)title{
  if (!_title) {
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title.backgroundColor = [UIColor clearColor];
    _title.font = DGBanner_Title_Font;
    _title.textAlignment=NSTextAlignmentLeft;
    _title.numberOfLines=2.0;
    _title.textColor = RGBCOLOR(255, 255, 255);
  }
  return _title;
}

#pragma mark - layout
- (void) layoutSubviews {
  [super layoutSubviews];
  self.title.frame = CGRectMake(40/2.0,self.dgHeight-52/2.0 , 400/2.0, 30/2.0);
}

@end
