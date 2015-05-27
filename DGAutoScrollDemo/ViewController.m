//
//  ViewController.m
//  DGAutoScrollDemo
//
//  Created by dullgrass on 15/5/27.
//  Copyright (c) 2015年 dullgrass. All rights reserved.
//

#import "ViewController.h"

#import "DGBannerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  id advData = [DGUtils readDataFromJsonWithFileName:@"adverData"];
  if ([advData isKindOfClass:[NSArray class]]) {
    DGBannerView *banner = [[DGBannerView alloc] initWithFrame:CGRectMake(0, 200, self.view.dgWidth, 160)];
    [self.view addSubview:banner];
    banner.bannerArray=advData;
    [banner setClickImageBlock: ^(NSInteger imageID){
      NSLog(@"imageID is %d",imageID);
    }];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
