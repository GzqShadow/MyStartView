//
//  StartView.m
//  demo
//
//  Created by mac on 15/12/9.
//  Copyright (c) 2015年 zsq. All rights reserved.
//

#import "StartView.h"
//#import "UIViewExt.h"
@interface StartView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSArray *imageNames;
@end
@implementation StartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _firstAnimationView];
//                self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}
-(void)_firstAnimationView{
    self.backgroundColor = [UIColor clearColor];
    
    //------------------创建滑动视图------------------
    
    //存放图片名字的数组
    NSArray *imageNames = @[@"Q1",@"Q2",@"Q3",@"Q5"];
    self.imageNames = imageNames;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    //取消滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    //回弹效果
    scrollView.bounces = NO;
    
    //内容视图的大小
    scrollView.contentSize = CGSizeMake(KScreenWidth * (imageNames.count + 1), kScreenHeight);
    
    //创建视图中的图片
    for (int i = 0; i < imageNames.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KScreenWidth, 0, KScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [scrollView addSubview:imageView];
        
    }
    //创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, KScreenWidth, 30)];
    pageControl.numberOfPages = 4;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    [pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    
    
}
- (void)pageControlAction:(UIPageControl *)pageControl{
    
    //设置当前scrollView的偏移量
    [self.scrollView setContentOffset:CGPointMake(KScreenWidth * pageControl.currentPage, 0) animated:YES];
}


//停止减速调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //设置pageControl的偏移量  //根据偏移量算出滑动界面的索引
    NSInteger pageIndex = scrollView.contentOffset.x/KScreenWidth;
    if (pageIndex < self.imageNames.count) {
        self.pageControl.currentPage = self.scrollView.contentOffset.x/KScreenWidth;
    }else
    {
        //到达最后一页
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.4];
    }
    
}

@end
