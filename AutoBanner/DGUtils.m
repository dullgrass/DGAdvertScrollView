//
//  DGUtils.m
//  DgShopModel
//
//  Created by dullgrass on 15/5/19.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import "DGUtils.h"

@implementation DGUtils

#pragma mark - 去除字典中的NULL
+ (NSDictionary *)replaceNSNULLWithCharacter:(NSDictionary *)data{
  if (data.count!=0) {
    NSArray* arr = [data allKeys];
    for(NSString* str in arr){
      if ( [[data objectForKey:str] isEqual:[NSNull null]]) {
        [data setValue:@"" forKey: str];
      }
    }
  }
  return data;
}

#pragma mark - 读取本地json文件内容
+ (id)readDataFromJsonWithFileName:(NSString *)fileName{
  
  NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  __autoreleasing NSError* error = nil;
  id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
  if (error != nil) return nil;
  return result;
}

@end
