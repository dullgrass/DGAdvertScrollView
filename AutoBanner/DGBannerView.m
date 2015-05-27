//
//  DGBannerView.m
//  DgShopModel
//
//  Created by dullgrass on 15/5/21.
//  Copyright (c) 2015年 grass dull. All rights reserved.
//

#import "DGBannerView.h"
#import "UIImageView+WebCache.h"
#import "DDPageControl.h"
#import <QuartzCore/QuartzCore.h>
#import "DGImageView.h"
#import "UIView+FullFrame.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DGBannerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *autoDataArr;   //!< 数据模型数组
@property (nonatomic, strong) NSTimer *autoStrollTime;       //!< 自动滚动定时器
@property (nonatomic, strong) DDPageControl *dotPage;        //!< 显示的page
@property (nonatomic, strong) UIScrollView *autoScroller;    //!< 自动滚动的scroller

@end

@implementation DGBannerView

#pragma mark - init
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame{
  
  if (self = [super initWithFrame:frame]) {
    
    [self initDataSource];
    
    [self addSubview:self.autoScroller];
    
    [self addSubview:self.dotPage];
    
    self.backgroundColor = UIColorFromRGB(0xF4F5F6);
    
  }
  return self;
}

- (void)awakeFromNib{
  
  [self initDataSource];
  
  [self addSubview:self.autoScroller];
  
  [self addSubview:self.dotPage];
}


- (void)initDataSource{
  
  self.autoDataArr = [[NSMutableArray alloc] init];
  self.animationTime = 1.0;
  self.animationWaitingTime = 3.0;
  self.pageOnColor = [UIColor colorWithRed:2/255.0 green:172/255.0 blue:223/255.0 alpha:1.0];
  self.pageOffColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:253/255.0 alpha:1.0];
}

- (UIScrollView *)autoScroller{
  
  if (!_autoScroller) {
    
    _autoScroller=[[UIScrollView alloc] initWithFrame:CGRectZero];
    _autoScroller.showsHorizontalScrollIndicator = NO;
    _autoScroller.showsVerticalScrollIndicator = NO;
    _autoScroller.pagingEnabled = YES;
    _autoScroller.scrollEnabled = YES;
    _autoScroller.bounces =NO;
    _autoScroller.delegate =  self;
    _autoScroller.backgroundColor = [UIColor clearColor];
    _autoScroller.userInteractionEnabled = YES;
  
  }
  return _autoScroller;
}

- (DDPageControl *)dotPage{
  
  if (!_dotPage) {
    _dotPage = [[DDPageControl alloc] initWithFrame:CGRectZero];
    [_dotPage setCurrentPage: 0] ;
    [_dotPage setDefersCurrentPageDisplay: YES] ;
    [_dotPage setType: DDPageControlTypeOnFullOffFull] ;
    [_dotPage setIndicatorDiameter: 7.0f] ;
    [_dotPage setIndicatorSpace: 7.0f] ;
  }
  return _dotPage;
}

#pragma mark - layout
#pragma mark -
- (void)setBannerArray:(NSArray *)bannerArray{
  
  for (NSDictionary *imageDic in bannerArray) {
    DGBannerModal *bannerModal = [[DGBannerModal alloc] initWithBannerData:imageDic];
    [self.autoDataArr addObject:bannerModal];
  }
  
  if (self.autoDataArr.count==1) {
    self.autoScroller.userInteractionEnabled=NO;
  }else{
    self.autoScroller.userInteractionEnabled=YES;
    self.autoStrollTime = [NSTimer scheduledTimerWithTimeInterval:self.animationWaitingTime target:self selector:@selector(scrollToNextPage:) userInfo:Nil repeats:YES];
  }
  
  self.autoScroller.frame = self.bounds;
  self.autoScroller.contentSize = CGSizeMake(self.dgWidth*self.autoDataArr.count, self.dgHeight);
  
  [self __setImageScrollerLogic];
  
  self.dotPage.numberOfPages = self.autoDataArr.count;
  self.dotPage.frame = CGRectMake(self.dgWidth-100,self.dgHeight-30, 100, 100);
  CGPoint pagePoint = self.center;
  pagePoint.y = self.dgHeight - 16;
  [self.dotPage setCenter: pagePoint];
  [self bringSubviewToFront:self.dotPage];
  
  [self.dotPage setOnColor: self.pageOnColor];
  [self.dotPage setOffColor: self.pageOffColor]  ;
  
}

#pragma mark - private
- (void)__setImageScrollerLogic{
  
  UIImage *coverImage=[UIImage imageNamed:@"placeHoldImage.png"];
  
  DGBannerModal *lastObject = [self.autoDataArr lastObject];
  
  DGImageView *firstView = [[DGImageView alloc] init];
  [firstView sd_setImageWithURL:lastObject.imageURL placeholderImage:coverImage];
  
  CGFloat Width = _autoScroller.frame.size.width;
  CGFloat Height = _autoScroller.frame.size.height;
  firstView.frame = CGRectMake(0, 0, Width, Height);
  firstView.userInteractionEnabled = YES;
  firstView.tag = lastObject.imageID;
  UITapGestureRecognizer *singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
  [firstView addGestureRecognizer:singleTap];
  firstView.title.text = lastObject.imageName;
  [_autoScroller addSubview:firstView];
  
  for (int i=0; i<[self.autoDataArr count]; i++){
    DGBannerModal *bannerModal = [self.autoDataArr objectAtIndex:i];
    
    DGImageView *subViews = [[DGImageView alloc] init];
    [subViews sd_setImageWithURL:bannerModal.imageURL placeholderImage:coverImage];
    subViews.frame = CGRectMake(Width*(i+1), 0, Width, Height);
    subViews.tag= bannerModal.imageID;
    subViews.userInteractionEnabled = YES;
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    [subViews addGestureRecognizer:singleTap];
    subViews.title.text = bannerModal.imageName;
    [_autoScroller addSubview:subViews];
   
  }
  
  DGBannerModal *firstModal = [self.autoDataArr firstObject];
  DGImageView *lastView = [[DGImageView alloc] init];
  lastView.frame = CGRectMake(Width*(self.autoDataArr.count+1), 0, Width, Height);
  lastView.tag=firstModal.imageID;
  lastView.userInteractionEnabled = YES;
  [lastView sd_setImageWithURL:firstModal.imageURL placeholderImage:coverImage];
  singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
  [lastView addGestureRecognizer:singleTap];
  [_autoScroller addSubview:lastView];
  lastView.title.text = firstModal.imageName;

  [_autoScroller setContentSize:CGSizeMake(Width* (self.autoDataArr.count+2), Height)];
  [self addSubview:_autoScroller];
  [_autoScroller scrollRectToVisible:CGRectMake(Width, 0, Width, Height) animated:NO];
}


#pragma mark - UIScrollViewDelegate
#pragma mark -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  CGFloat pageWidth=_autoScroller.frame.size.width;
  long currentPage=floor((_autoScroller.contentOffset.x-pageWidth/2)/pageWidth)+1;
  if (currentPage==0){
    [self.dotPage setCurrentPage:self.autoDataArr.count-1];
    [self.dotPage updateCurrentPageDisplay] ;
    return;
  }
  else if(currentPage==self.autoDataArr.count+1){
    [self.dotPage setCurrentPage:0];
    [self.dotPage updateCurrentPageDisplay] ;
    return;
  }
  [self.dotPage setCurrentPage:currentPage-1];
  if (scrollView.dragging)
    [self.dotPage updateCurrentPageDisplay] ;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  [self.autoStrollTime invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  self.autoStrollTime=[NSTimer scheduledTimerWithTimeInterval:self.animationWaitingTime target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  CGFloat pageWidth=self.autoScroller.frame.size.width;
  CGFloat pageHeigth=self.autoScroller.frame.size.height;
  long currentPage=floor((self.autoScroller.contentOffset.x-pageWidth/2)/pageWidth)+1;
  if (currentPage==0){
    [self.autoScroller scrollRectToVisible:CGRectMake(pageWidth*self.autoDataArr.count, 0, pageWidth, pageHeigth) animated:NO];
    self.dotPage.currentPage=self.autoDataArr.count-1;
    [self.dotPage updateCurrentPageDisplay] ;
    return;
  }
  else  if(currentPage==[self.autoDataArr count]+1){
    [self.autoScroller scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
    
    [self.dotPage setCurrentPage:0];
    [self.dotPage updateCurrentPageDisplay] ;
    return;
  }
  [self.dotPage setCurrentPage:currentPage-1];
  if (scrollView.dragging)
    [self.dotPage updateCurrentPageDisplay] ;
}

#pragma mark - scrollToNext Logic
#pragma mark -
-(void)scrollToNextPage:(id)sender{
  long  int pageNum =self.dotPage.currentPage;
  CGSize viewContentSize = self.autoScroller.frame.size;
  [UIView beginAnimations:@"ViewFlip" context:nil];
  [UIView setAnimationDuration:1.0];
  [UIView setAnimationDelegate:self];
  if (pageNum==self.autoDataArr.count-1) {
    [UIView setAnimationDidStopSelector:@selector(updateCircleData)];
  }
  [UIView  setAnimationCurve: UIViewAnimationCurveEaseOut];
  [self.autoScroller setContentOffset:CGPointMake((pageNum+2)*viewContentSize.width, 0)];
  [UIView commitAnimations];
  [self.dotPage updateCurrentPageDisplay] ;
}

- (void)updateCircleData{
  [self.autoScroller setContentOffset:CGPointMake(self.dgWidth, 0)];
}


#pragma mark - click current image 
#pragma mark -
- (void)clickImage:(UITapGestureRecognizer *)tap{
  if (self.clickImageBlock) {
    self.clickImageBlock(tap.view.tag);
  }
  
}

- (void)setClickImageBlock:(ClickImageBlock)clickImageBlock{
  _clickImageBlock = clickImageBlock;
}
@end
