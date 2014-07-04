//
//  ChildrenViewController.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ChildrenViewController.h"
#import "AppDelegate.h"
#import "CollectView.h"
#import "GatherView.h"
#import "ASIHTTPRequest.h"
#import "ChannelCatContentListModel.h"
#import "Commonality.h"
#import "IVMallPlayer.h"

#define CHILDTAG 10000
@interface ChildrenViewController ()<ASIHTTPRequestDelegate>{
    CGRect pagRect;
}

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@property(nonatomic,copy)NSString* tmpName;

@end

#define MAXITEMNUM   (10)
@implementation ChildrenViewController
@synthesize gatherView=gatherView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:CATALLLIST]];
    _isShowingAlartView = NO;
    isLoadNextPage = NO;
    _showSate=NO;
    _allMutableDictionary=[[NSMutableDictionary alloc]init];
    
    
    UIImageView * backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    backImage.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:backImage];
    
    rect=[UIScreen mainScreen].bounds;
    UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.height, [AppDelegate App].countIOS7)];
    backView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:backView];
    
    UIView*tapView=[[UIView alloc]initWithFrame:CGRectMake(0, [AppDelegate App].countIOS7, rect.size.height, 48)];
    tapView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tapView];
    
    UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:@"History.png"] forState:(UIControlStateNormal)];
    button.frame=CGRectMake(rect.size.height-49.5, (tapView.frame.size.height-29.5)/2, 29.5, 29.5);
    [button addTarget:self action:@selector(clickRecently) forControlEvents:UIControlEventTouchUpInside];
//    [tapView addSubview:button];
    
    UIButton*userButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    userButton.frame=CGRectMake(button.frame.origin.x-29.5-33, button.frame.origin.y, button.frame.size.height,button.frame.size.width);
//    [userButton addTarget:self action:@selector(clickUserButton:) forControlEvents:UIControlEventTouchUpInside];
//    [userButton setBackgroundImage:[UIImage imageNamed:@"IndividualCenter.png"] forState:(UIControlStateNormal)];
//    [tapView addSubview:userButton];
//    userButton.exclusiveTouch = YES;
    
    UIImageView* userBgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IndividualCenter_bg.png"]];
    userBgImage.frame=CGRectMake(button.frame.origin.x-29.5, button.frame.origin.y-10, button.frame.size.height+ 20,button.frame.size.width+20);
    userButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    userButton.frame=CGRectMake(10, 10, button.frame.size.height,button.frame.size.width);
    [userButton addTarget:self action:@selector(clickUserButton:) forControlEvents:UIControlEventTouchUpInside];
    [userButton setBackgroundImage:[UIImage imageNamed:@"IndividualCenter.png"] forState:(UIControlStateNormal)];
    [tapView addSubview:userBgImage];
    [userBgImage addSubview:userButton];
    userBgImage.userInteractionEnabled = YES;
    //    [tapView addSubview:userButton];
    

    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(35, 15, 30, 30)];
    img.image = [UIImage imageNamed:@"iVmall.png"];
    img.backgroundColor = [UIColor clearColor];
    [tapView addSubview:img];
    
//    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 2, 80, 40)];
//    titleLabel.backgroundColor=[UIColor clearColor];
//    titleLabel.text=@"幼幼猫";
//    titleLabel.textColor=[UIColor whiteColor];
//    titleLabel.font=[UIFont boldSystemFontOfSize:17];
//    titleLabel.alpha=ALOPH;
//    [tapView addSubview:titleLabel];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];

    _myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(5, tapView.frame.origin.y+tapView.frame.size.height+65, rect.size.height-10, rect.size.width-230)];
    _myScrollView.showsHorizontalScrollIndicator=NO;
    _myScrollView.showsVerticalScrollIndicator=NO;
    _myScrollView.pagingEnabled=YES;
    _myScrollView.delegate=self;
    _myScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_myScrollView];
    
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, tapView.frame.origin.y+tapView.frame.size.height, rect.size.height, 40)];
    _scrollView2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"分类背景.png"]];
    [self.view addSubview:_scrollView2];
    
    linView=[[UIView alloc]initWithFrame:CGRectMake(_myScrollView.frame.origin.x+20, _myScrollView.frame.origin.y+_myScrollView.frame.size.height+10, rect.size.height-40, 0.5)];
    linView.backgroundColor=[UIColor whiteColor];
    linView.alpha=0.1;
//    [self.view addSubview:linView];
    
    _pageCont=[[UIPageControl alloc]initWithFrame:CGRectMake((_myScrollView.frame.size.width)/2-130, linView.frame.origin.y-5, 0, 10)];
    pagRect=_pageCont.frame;
//    _pageCont.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _pageCont.userInteractionEnabled=NO;
    _pageCont.hidesForSinglePage=YES;
    _pageCont.pageIndicatorTintColor=color_14;
    _pageCont.currentPageIndicatorTintColor=color_2;
    [self.view addSubview:_pageCont];

    scroBackView=[[BackView alloc]init];
    
    [self setUpForDismissKeyboard];
    now=[[NoWifiView alloc]initWithFrame:_myScrollView.frame];
    now.delegate=self;
    [self.view addSubview:now];

    now.hidden=YES;
    _isWifiResume = NO;
  
    
    lodingBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [lodingBgView setBackgroundColor:[UIColor clearColor]];
    UIActivityIndicatorView* activeIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
    activeIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [activeIndicatorView startAnimating];
    activeIndicatorView.center = lodingBgView.center;
    [lodingBgView addSubview:activeIndicatorView];
    [self.view addSubview:lodingBgView];
    
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(CollectChanged) name:NSNotificationCenter_CollectChanged object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(CollectChanged) name:NSNotificationCenter_LoginOut object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(CollectChanged) name:NSNotificationCenter_LoginIn object:nil];
}

-(void)CollectChanged
{
    [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:MAXITEMNUM categoryId:_tmpCategoryId delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NSNotificationCenter_CollectChanged object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NSNotificationCenter_LoginOut object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NSNotificationCenter_LoginIn object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [HttpRequest myCancelAsi];
}

-(void)refreshRecom
{
    if (_showSate) {
        _showSate=NO;
        return;
    }
//    if ([Commonality isEnableWIFI]) {
//        [HttpRequest categoryRequestChannelCode:@"children" pag:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    }
    _pageCont.currentPage=0;
    _index=0;
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    cacheDic=[user objectForKey:@"children_cache"];
    if ([Commonality isEnableWIFI]==0&&cacheDic==nil) {
        now.hidden=NO;
        return;
    }
    NSDictionary*dic=[user objectForKey:@"children_heat_cache"];
    if (dic!=nil) {
        [self passGory:dic];
    }
    now.hidden=YES;
    [self postCatRequest];
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[user objectForKey:[NSString stringWithFormat:@"category_cache_%@",_tmpCategoryId]];
    self.view.userInteractionEnabled = YES;
    if (_showSate == YES) {
        _showSate=NO;
        return;
    }
//    if ([Commonality isEnableWIFI]) {
//        [HttpRequest categoryRequestChannelCode:@"children" pag:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    }
    _pageCont.currentPage=0;
    _index=0;
    if ([Commonality isEnableWIFI]==0&&dic==nil) {
        now.hidden=NO;
        return;
    }else if([Commonality isEnableWIFI]==0&&dic!=nil){
        isLoadNextPage = NO;
        [self passCatDic:dic count:0];
        [lodingBgView setHidden:YES];
        now.hidden=YES;
        return;
    }else{
    }
    dic=[user objectForKey:@"children_heat_cache"];
    if (dic!=nil) {
        [self passGory:dic];
    }
    
    if (cacheDic!=nil) {
        if (isLoadNextPage == NO) {
            [self passCatDic:cacheDic count:0];
        }
    }
    
    now.hidden=YES;
    [self postCatRequest];
}

-(void)loadNextPage
{
//    [HttpRequest VideoAllRequest:[AppDelegate App].personModel.tokenid channelCode:@"children" index:(self.pageCont.currentPage + 1)*12 offset:12 categoryId:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    
//    [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:12 categoryId:_tmpCategoryId delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    
    if (_tmpCategoryId.length<2) {
        [HttpRequest VideoAllRequest:[AppDelegate App].personModel.tokenid channelCode:@"children" index:(self.pageCont.currentPage + 1)*MAXITEMNUM offset:MAXITEMNUM categoryId:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:(self.pageCont.currentPage + 1)*MAXITEMNUM offset:MAXITEMNUM categoryId:_tmpCategoryId delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        
    }
}

#pragma nowifi  delegate
-(void)callBackClickrech{
    [self postCatRequest];
}

-(void)postCatRequest{
//    _tmpCategoryId=@"";
//    [_myScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//    [HttpRequest VideoAllRequest:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:12 categoryId:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    
//    if ([Commonality isEnableWIFI]) {
//        [HttpRequest categoryRequestChannelCode:@"children" pag:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    }

    
}

-(void)clickRecently{
    
//    if ([AppDelegate App].isLogin==NO) {
//        if ([AppDelegate App].userView == nil) {
//            [AppDelegate App].userView = [[UserView alloc] initMy];
//        }
//        
//        if ([AppDelegate App].userView.hihel == NO) {
//            [[AppDelegate App].userView dismiss];
//        }
//        else
//        {
//            [[AppDelegate App].userView showFromPlayHistory];
//        }
//        if ([AppDelegate App].registView.hihel == YES) {
//            [[AppDelegate App].registView dismiss];
//        }
//        if ([AppDelegate App].forgetPasswordView.hihel == YES) {
//            [[AppDelegate App].forgetPasswordView dismiss];
//        }
//        return;
//    }
//    
//    if ([AppDelegate App].playHistVIew==nil) {
//        [AppDelegate App].playHistVIew=[[PlayHistoryView alloc]initMy];
//    }
//    
//    [Commonality dismissAllView1];
}

-(void)clickClassButton:(int)sender{
    
    _index=0;
    _pageCont.currentPage=0;
    if (![[AppDelegate App].cateArray count]) {
        return;
    }
    ChannelCategoryListModel*cah=[[AppDelegate App].cateArray objectAtIndex:sender];
    for(UIView *view in [_myScrollView subviews]){
        [view removeFromSuperview];
    }
    [_myScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    _tmpCategoryId=cah.categoryId;
    
    if (_request) {
        [_request cancel];
        _request = nil;
        _request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:CATALLLIST]];
    }

    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[user objectForKey:[NSString stringWithFormat:@"category_cache_%@",_tmpCategoryId]];
    if ([Commonality isEnableWIFI]==0&&dic==nil) {
        [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:MAXITEMNUM categoryId:_tmpCategoryId request:_request delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else if([Commonality isEnableWIFI]==0&&dic!=nil){
        isLoadNextPage = NO;
        [self passCatDic:dic count:0];
        [lodingBgView setHidden:YES];
        now.hidden=YES;
    }else{
        [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:MAXITEMNUM categoryId:_tmpCategoryId request:_request delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        [lodingBgView setHidden:NO];
    }
}

-(void)makeRecommEndView:(int)count arr:(NSMutableArray*)arr{
    if (count==0) {
        for(UIView *view in [_myScrollView subviews]){
            [view removeFromSuperview];

        }
        [_allMutableDictionary removeAllObjects];
    }
    
    [scroBackView removeFromSuperview];

    if (_recomm) {
        _recomm = nil;
    }
    
//    UIView*view=[_myScrollView viewWithTag:CHILDTAG+count];
//    if (view) {
//        [view removeFromSuperview];
//        view = nil;
//    }
    
    Recommend8View * recom=[[Recommend8View alloc]initWithFrame:CGRectMake(_myScrollView.frame.size.width*count, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height) data:arr];
    recom.delegate=self;
    if (gatherView) {
        gatherView.delegate1 = recom;
    }
    recom.tag=CHILDTAG+count;
    _recTag = recom.tag;
    recom.backgroundColor=[UIColor clearColor];
    [_myScrollView addSubview:recom];
    
    [_allMutableDictionary setObject:arr forKey:[NSString stringWithFormat:@"View_arr_%i",recom.tag]];
    _recomm = [[Recommend8View alloc] init];
    _recomm = recom;
}

-(void)clickUserButton:(UIButton*)sender{

//    [Commonality clickUserBtn];
    PersonnalCenter * personView = [AppDelegate App].personView;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:personView];
    nav.navigationBarHidden = YES;
    [[AppDelegate App].tabBarController.navigationController pushViewController:personView animated:YES];
}

#pragma Gather delegaet
-(void)callbackPlay:(NSString *)url name:(NSString *)nsme{
    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:url withVideoName:nsme fromViewController:[AppDelegate App].tabBarController startTime:0];
}
-(void)changeFavouriteState
{
//    [self refreshRecom];
    
}
#pragma pop delegate
-(void)callbackGatherClassName:(id)className count:(int)tag{
   
    NSArray*arr=[_allMutableDictionary objectForKey:[NSString stringWithFormat:@"View_arr_%@",className]];
    CHECK_NONERETURN(arr.count > tag-1000);
    ChannelCatContentListModel*catModel=[arr objectAtIndex:tag-1000];
    
    if ([catModel.contentType isEqualToString:@"vod"]) {
        if (catModel.isEpisode==1) {
            
            if (gatherView) {
                [gatherView dismiss];
                gatherView = nil;
            }
            
            if (gatherView==nil) {
                gatherView=[[GatherView alloc]initMy:catModel];
                gatherView.delegate=self;
                gatherView.delegate1 = _recomm;
            }
            catModel.modelTag = tag;
            [gatherView show:catModel];

            return;
        }
    }
    if ([AppDelegate App].isLogin==NO) {
        [Commonality dismissAllView];
        return;
    }
    
    self.tmpName=catModel.contentTitle;
    
    
    [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:catModel.contentGuid startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
}

-(void) GetErr:(ASIHTTPRequest *)request{
    
    if (request.error.code == 4) {
        return;
    }
    if (_isShowingAlartView == NO) {
        if ([Commonality isEnableWIFI]) {
            NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
            NSDictionary*dic=[user objectForKey:[NSString stringWithFormat:@"category_cache_%@",_tmpCategoryId]];
            [self passCatDic:dic count:0];
            [lodingBgView setHidden:YES];
            now.hidden=YES;
            return;
        }
        UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接异常，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alvIew.tag = 502;
        [alvIew show];
        _isShowingAlartView = YES;
    }
}

-(void) GetResult:(ASIHTTPRequest *)request{
    _isWifiResume = YES;
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    [lodingBgView setHidden:YES];
    if (dictionary==nil) {
        [Commonality showErrorMsg:self.view type:0 msg:@"网络连接异常，请重试"];
        
    }else{
        if (request.tag==ADDFAVORITE_TYPE){
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                [Commonality showErrorMsg:self.view type:0 msg:@"收藏成功!"];
            }else{
                [Commonality showErrorMsg:self.view type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
            }
            
            
        }else if (request.tag==PLAYEVEDIO_type){
            ProductPlayModel*url=[[ProductPlayModel alloc]initWithDictionary:dictionary];
            if (url.result==0) {
                NSString*str=nil;
                if (url.URI.length>1.0) {
                    str=url.URI;
                }else{
                    str=url.catchupURI;
                }
                _showSate=YES;
                
                [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:0];
                
            }else{
                if (url.result == 204) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"会员权限未开通或已过期" message:@"请先开通会员！" delegate:self cancelButtonTitle:@"稍后开通" otherButtonTitles:@"立即开通", nil];
                    [alert show];
                    return;
                }
                [Commonality showErrorMsg:self.view type:url.result msg:@"网络连接异常，请重试"];
                
            }
        }else if (request.tag==CATEGORY_TYPE){
           
            [self passGory:dictionary];
            
        }else if (request.tag==DETAILURL_TYPE) {
            
        } else{
//            if (_index == 0) {
                isLoadNextPage = YES;
                [self passCatDic:dictionary count:request.tag];
//            }
            if (request.tag == 0) {
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:dictionary forKey:[NSString stringWithFormat:@"category_cache_%@",_tmpCategoryId]];
                [user synchronize];
            }
            
        }
        
        
    }

}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag != 502) {
        if (buttonIndex == 1) {
            [self performSelector:@selector(showMyProgramPackageView) withObject:nil afterDelay:1];
        }
    }
    else
    {
        _isShowingAlartView = NO;
    }
}

-(void)showMyProgramPackageView
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.isShowFromMain = YES;
    pro.productId = productID;
    [pro show];
}

-(void)passGory:(NSDictionary*)dic{
    return;
//    ChannelCategoryListModel*cat=[[ChannelCategoryListModel alloc]initWithDictionary:dic modelList:_cateArray page:1];
//    if (cat.result==0) {
//        NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
//        [user setObject:dic forKey:@"children_heat_cache"];
//        [user synchronize];
//        
//        for(UIView *view in [_scrollView2 subviews]){
//            [view removeFromSuperview];
//        }
//        UIButton*but=nil;
//        for (int i=0; i<[_cateArray count]+1; i++) {
//            
//            UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
//            button.titleLabel.font=[UIFont boldSystemFontOfSize: 15];
//            button.frame=CGRectMake(10, 2, 100, 38);
//            if (but==nil) {
//                but=button;
//            }
//            if (i==0) {
//                [button setTitle:@"全部" forState:(UIControlStateNormal)];
//                CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(button.titleLabel.frame.size.width ,MAXFLOAT)];
//                button.frame=CGRectMake(10, 2, size.width+5, 38);
//                
//                _selectBut=button;
//            }else{                
//                ChannelCategoryListModel*cah=[_cateArray objectAtIndex:i-1];
//                if ([cah.categoryName rangeOfString:@"直播"].location != NSNotFound) {
//                    return;
//                }
//                [button setTitle:cah.categoryName forState:(UIControlStateNormal)];
//                CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(button.titleLabel.frame.size.width ,MAXFLOAT)];
//                
//                button.frame=CGRectMake(but.frame.origin.x+but.frame.size.width+20, 2, size.width+5, 38);
//            }
//            
//            button.backgroundColor=[UIColor clearColor];
//            button.alpha=ALOPH;
//            button.layer.cornerRadius=4;
//            button.tag=10+i;
//            but=button;
//            [button addTarget:self action:@selector(clickClassButton:) forControlEvents:UIControlEventTouchUpInside];
//            [_scrollView2 addSubview:button];
//            _selectBut.alpha=1;
//        }
//        _scrollView2.contentSize=CGSizeMake(but.frame.origin.x+but.frame.size.width+20, 0);
//        
//        _selectBut.userInteractionEnabled=NO;
//        
//    }else{
//        [Commonality showErrorMsg:self.view type:cat.result msg:@"网络连接异常，请重试"];
//    }
}

-(void)passCatDic:(NSDictionary*)dic count:(int)count{
    NSMutableArray*arr=[[NSMutableArray alloc]init];
    ChannelCatContentListModel*catlist=[[ChannelCatContentListModel alloc]initWithDictionary:dic modelList:arr page:1];
    
    if (catlist.result==0) {
        if (count==0) {
            if (_selectBut.tag==10) {
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:dic forKey:@"children_cache"];
                [user synchronize];
            }
        }
        
        int i=0;
        if (catlist.allCoun%MAXITEMNUM!=0) {
            i=1;
        }
        _pageCont.numberOfPages=catlist.allCoun/MAXITEMNUM+i;
        if (_pageCont.numberOfPages==1) {
            linView.hidden=YES;
        }
        _myScrollView.contentSize=CGSizeMake(_myScrollView.frame.size.width*_pageCont.numberOfPages, 0);
        CGSize siz=[_pageCont sizeForNumberOfPages:_pageCont.numberOfPages];
        _pageCont.frame=CGRectMake(ABS(pagRect.origin.x-ABS((siz.width-pagRect.size.width))/2)+130, pagRect.origin.y, siz.width, pagRect.size.height);
        
        if (count!=0) {
            [self makeRecommEndView:count/MAXITEMNUM+count%MAXITEMNUM arr:arr];
            if ((self.pageCont.currentPage)*MAXITEMNUM == count) {
                [self loadNextPage];
                isLoadNextPage = NO;
            }
        }else{
            [self makeRecommEndView:count arr:arr];
            if (isLoadNextPage == YES) {
                [self loadNextPage];
                isLoadNextPage = NO;
            }
        }
        
    }else{
        [Commonality showErrorMsg:self.view type:catlist.result msg:@"网络连接异常，请重试"];

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/_myScrollView.frame.size.width;
    self.pageCont.currentPage = page;
    if (abs(_myScrollView.contentOffset.x/_myScrollView.frame.size.width)!=0) {
        UIView*view=[_myScrollView viewWithTag:CHILDTAG+page];
        if (view==nil) {
            scroBackView.frame=CGRectMake(_myScrollView.frame.size.width*page, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height);
            if (page+1==self.pageCont.numberOfPages) {
                [scroBackView show:(_pageCont.numberOfPages*MAXITEMNUM)%MAXITEMNUM];
            }else{
                [scroBackView show:MAXITEMNUM];
            }
            [_myScrollView addSubview:scroBackView];
            _index=page*MAXITEMNUM;
            
            if (_tmpCategoryId.length<2) {
                [HttpRequest VideoAllRequest:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:MAXITEMNUM categoryId:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }else{
                [HttpRequest VideoAllRequest2:[AppDelegate App].personModel.tokenid channelCode:@"children" index:_index offset:MAXITEMNUM categoryId:_tmpCategoryId delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
         
        }

            if (lastPage < self.pageCont.currentPage) {
                //[self loadNextPage];
                lastPage = self.pageCont.currentPage;
            }
        
      
    }else if(_myScrollView.contentOffset.x/_myScrollView.frame.size.width==0){
       
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}
@end






