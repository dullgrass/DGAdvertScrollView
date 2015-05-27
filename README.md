# DGAdvertScrollView
scrollView GUI Widget which helps you display automatic cycle ads easier
## Requirements

DGAdvertScrollView works on iOS 6.0  and later version . It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation.framework
* UIKit.framework
* QuartzCore.framework

You will need LLVM 3.0 or later in order to build DGAdvertScrollView.


## Usage

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add DGAdvertScrollView to your project.

1. Add a pod entry for DGAdvertScrollView to your Podfile `pod 'DGAdvertScrollView'`
2. Install the pod(s) by running `pod install`.
3. Include DGAdvertScrollView wherever you need it with `#import "DGBannerView.h"`.


### Manually

   Copy the DGAdvertScrollView folder to your project and add related library DDPageControl and SDWebImage
   
## How to Use
   Briefly,you can use it with both code and storyboard.
```objective-c
   #import "DGBannerView.h"

   id advData = [DGUtils readDataFromJsonWithFileName:@"adverData"];
   if ([advData isKindOfClass:[NSArray class]]) {
    DGBannerView *banner = [[DGBannerView alloc] initWithFrame:CGRectMake(0, 200, self.view.dgWidth, 160)];
    [self.view addSubview:banner];
    banner.bannerArray=advData;
    [banner setClickImageBlock: ^(NSInteger imageID){
      NSLog(@"imageID is %d",imageID);
    }];
  }
