//
//  BackDemo.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-28.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "BackDemo.h"

@implementation BackDemo

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    slectBUtton.backgroundColor=[UIColor clearColor];
//    if (_myScrollView.contentOffset.x==1024) {
//        slectBUtton=(UIButton*)[tapView viewWithTag:1001];
//    }else if (_myScrollView.contentOffset.x==2048){
//        slectBUtton=(UIButton*)[tapView viewWithTag:1002];
//    }else if (_myScrollView.contentOffset.x==3072){
//        slectBUtton=(UIButton*)[tapView viewWithTag:1003];
//    }else if(_myScrollView.contentOffset.x==0){
//        slectBUtton=(UIButton*)[tapView viewWithTag:1000];
//    }else if (_myScrollView.contentOffset.x==4096){
//        slectBUtton=(UIButton*)[tapView viewWithTag:1004];
//    }
//    slectBUtton.backgroundColor=[UIColor cyanColor];
//
//}
//-(void)clickClassButton:(UIButton*)sender{
//    sender.backgroundColor=[UIColor cyanColor];
//    slectBUtton.backgroundColor=[UIColor clearColor];
//    slectBUtton=sender;
//
//    if (sender.tag-1000==0) {
//        [_myScrollView setContentOffset:CGPointMake(rect.size.height*0, 0) animated:YES];
//    }else if (sender.tag-1000==1){
//        [_myScrollView setContentOffset:CGPointMake(rect.size.height*1, 0) animated:YES];
//
//    }else if (sender.tag-1000==2){
//        [_myScrollView setContentOffset:CGPointMake(rect.size.height*2, 0) animated:YES];
//
//    }else if (sender.tag-1000==3){
//        [_myScrollView setContentOffset:CGPointMake(rect.size.height*3, 0) animated:YES];
//
//    }else{
//        [_myScrollView setContentOffset:CGPointMake(rect.size.height*4, 0) animated:YES];
//    }
//}


//    _myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, rect.size.height, rect.size.width-170)];
//    _myScrollView.contentSize=CGSizeMake(_myScrollView.frame.size.width*5, 0);
//    _myScrollView.showsHorizontalScrollIndicator=NO;
//    _myScrollView.showsVerticalScrollIndicator=NO;
//    _myScrollView.pagingEnabled=YES;
//    _myScrollView.delegate=self;
//    _myScrollView.backgroundColor=[UIColor greenColor];
//
//    Recommend1*recom=[[Recommend1 alloc]initMy:CGRectMake(0, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:nil];
//    recom.delegaet=self;
//    [_myScrollView addSubview:recom];
//
//    Recommend2View*rrecom2=[[Recommend2View alloc]initWithFrame:CGRectMake(_myScrollView.frame.size.width, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:nil];
//    rrecom2.delegaet=self;
//    [_myScrollView addSubview:rrecom2];
//
//    Recommend3View*rrecom3=[[Recommend3View alloc]initWithFrame:CGRectMake(_myScrollView.frame.size.width*2, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:nil];
//    rrecom3.delegaet=self;
//    [_myScrollView addSubview:rrecom3];
//
//    Recommend4View*rrecom4=[[Recommend4View alloc]initWithFrame:CGRectMake(_myScrollView.frame.size.width*3, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:nil];
//    [_myScrollView addSubview:rrecom4];
//
//    Recommend5View*rrecom5=[[Recommend5View alloc]initWithFrame:CGRectMake(_myScrollView.frame.size.width*4, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:nil];
//    [_myScrollView addSubview:rrecom5];
//    [self.view addSubview:_myScrollView];
//
//    UIButton*moreButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    moreButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//    moreButton.frame=CGRectMake(rect.size.height-100, _myScrollView.frame.origin.y+_myScrollView.frame.size.height+5, 80, 35);
//    [moreButton setTitle:@"更多" forState:(UIControlStateNormal)];
//    [moreButton greyStyle];
//    [self.view addSubview:moreButton];


//    NSArray*arra=[NSArray arrayWithObjects:@"推荐",@"动漫推荐",@"劲爆体育",@"时尚推荐",@"最新直播", nil];
//    for (int i=0; i<[arra count]; i++) {
//        UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
//        button.frame=CGRectMake(i*80+40*i, 2, 80, 40);
//        button.backgroundColor=[UIColor clearColor];
//        button.titleLabel.font=[UIFont boldSystemFontOfSize: 15];
//        button.tag=1000+i;
//        [button addTarget:self action:@selector(clickClassButton:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:[arra objectAtIndex:i] forState:(UIControlStateNormal)];
//        [tapView addSubview:button];
//    }
//
//    slectBUtton=(UIButton*)[tapView viewWithTag:1000];
//    slectBUtton.backgroundColor=[UIColor cyanColor];


@end
