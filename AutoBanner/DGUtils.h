//
//  DGUtils.h
//  DgShopModel
//
//  Created by dullgrass on 15/5/19.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGUtils : NSObject
/*!
 *  去除字典中的null
 *
 *  @param data 需要替换的字典
 *
 *  @return 替换后的字典
 */
+ (NSDictionary *)replaceNSNULLWithCharacter:(NSDictionary *)data;

/*!
 *  根据json文件名称，读取json文件内容
 *
 *  @param fileName json文件名称
 *
 *  @return NSArray或者NSDictionary，json内容
 */
+ (id)readDataFromJsonWithFileName:(NSString *)fileName;

@end
