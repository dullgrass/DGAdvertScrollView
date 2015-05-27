//
//  DGBannerModal.h
//  DGShopClient
//
//  Created by dullgrass on 15/5/25.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGBannerModal : NSObject

@property (nonatomic, strong) NSURL *imageURL;           //!< 图片的URL地址
@property (nonatomic, assign) NSInteger imageID;         //!< 图片的ID
@property (nonatomic, strong) NSString *imageName;       //!< 图片名称

- (instancetype)initWithBannerData:(NSDictionary *)data;

@end
