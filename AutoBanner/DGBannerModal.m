//
//  DGBannerModal.m
//  DGShopClient
//
//  Created by dullgrass on 15/5/25.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import "DGBannerModal.h"

@implementation DGBannerModal

- (instancetype)initWithBannerData:(NSDictionary *)data{
  if (self = [super init]) {
    
    data = [DGUtils replaceNSNULLWithCharacter:data];
    self.imageURL = [NSURL URLWithString:[data objectForKey:@"image_url"]];
    self.imageID = [[data objectForKey:@"image_id"] integerValue];
    self.imageName = [data objectForKey:@"image_name"];
  }
  return self;
}

@end
