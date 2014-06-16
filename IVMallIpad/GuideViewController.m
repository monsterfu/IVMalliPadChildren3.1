//
//  GuideViewController.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-28.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "GuideViewController.h"
#import "UIButton+Bootstrap.h"
#import "AppDelegate.h"
@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    rect=[UIScreen mainScreen].bounds;
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, rect.size.height, rect.size.width)];
    scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.contentSize=CGSizeMake(rect.size.height*3, 0);
    scrollView.delegate=self;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    NSArray*colo=[NSArray arrayWithObjects:[UIColor grayColor],[UIColor greenColor],[UIColor purpleColor], nil];
    for (int i=0; i<3; i++) {
        UIImageView*imgView=[[UIImageView alloc]initWithImage:nil];
        imgView.backgroundColor=[colo objectAtIndex:i];
        imgView.frame=CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        
        if (i==2) {
            imgView.userInteractionEnabled=YES;
            UIButton*okButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [okButton setTitle:@"进入首页" forState:(UIControlStateNormal)];
            okButton.frame=CGRectMake(scrollView.frame.size.width/2-50, scrollView.frame.size.height-100, 100, 40);
            [okButton redStyle];
            [okButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:okButton];
        }
        [scrollView addSubview:imgView];
    }
    
    [self.view addSubview:scrollView];
    _pageCont=[[UIPageControl alloc]initWithFrame:CGRectMake((rect.size.width)/2-50, rect.size.width-40, 100, 20)];
    _pageCont.backgroundColor=[UIColor clearColor];
    _pageCont.numberOfPages=3;
    _pageCont.currentPage=0;
    _pageCont.pageIndicatorTintColor=[UIColor blackColor];
    _pageCont.currentPageIndicatorTintColor=[UIColor orangeColor];
    [self.view addSubview:_pageCont];
    
}

-(void)clickButton{
    [self presentViewController:[AppDelegate App].tabBarController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.height;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageCont.currentPage = page;
}

@end
