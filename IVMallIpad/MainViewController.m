//
//  MainViewController.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "MainViewController.h"
#import "UserView.h"
#import "AppDelegate.h"
#import "BuyView.h"
#import "GatherView.h"
#import "UIButton+Bootstrap.h"
#import "GuideViewController.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "IndexAllInfo.h"
#import "AdMOdel.h"
#import "ChannelsModel.h"
#import "IVMallPlayer.h"
#import "ChildrenProductView.h"
#import "IndexFeaturedHomeModel.h"
#import "UserPreferenceModel.h"
#import "ProgramPackage.h"

@interface MainViewController ()<ASIHTTPRequestDelegate>

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@property(nonatomic,copy)NSString* tmpName;


@end


#define ITEM_SPACING 250

static UIView*sleckView;
@implementation MainViewController
@synthesize wrap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        wrap=YES;
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
//    if (adscrollerView) {
//        [adscrollerView.timer setFireDate:[NSDate distantFuture]];
//    }
    self.view.userInteractionEnabled = NO;
    [HttpRequest myCancelAsi];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imgArr = [[NSMutableArray alloc] init];
    _titleArr = [[NSMutableArray alloc] init];
    self.view.exclusiveTouch = YES;
    _isShowingAlartView = NO;
    rect=[UIScreen mainScreen].bounds;
    _myArray=[[NSMutableArray alloc]init];
    _adArr = [[NSMutableArray alloc] init];
    _childrenArr = [[NSMutableArray alloc] init];
    
    UIImageView * backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    backImage.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:backImage];
    
    UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.height, [AppDelegate App].countIOS7)];
    backView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:backView];
    
    tapView=[[UIView alloc]initWithFrame:CGRectMake(0, [AppDelegate App].countIOS7, rect.size.height, 48)];
    tapView.backgroundColor=[UIColor clearColor];
//    tapView.userInteractionEnabled=YES;
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(35, 15, 30, 30)];
    img.image = [UIImage imageNamed:@"iVmall.png"];
    img.backgroundColor = [UIColor clearColor];
    [tapView addSubview:img];
    
//    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 2, 80, 40)];
//    titleLabel.backgroundColor=[UIColor clearColor];
//    titleLabel.text=@"推荐";
//    titleLabel.textColor=[UIColor whiteColor];
//    titleLabel.font=[UIFont boldSystemFontOfSize:17];
//    titleLabel.alpha=ALOPH;
//    [tapView addSubview:titleLabel];

    UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:@"History.png"] forState:(UIControlStateNormal)];
    button.frame=CGRectMake(rect.size.height-49.5, (tapView.frame.size.height-29.5)/2, 29.5, 29.5);
    [button addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
//    [tapView addSubview:button];
    
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

    
//    UIImageView * backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
//    backImage.image = [UIImage imageNamed:@"bg.png"];
//    [self.view addSubview:backImage];
    
    
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:tapView];
    

    
    
    if ([Commonality isEnableWIFI]==1) {
        for (int i = 0; i < 6; i++) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ChildrenProductView" owner:self options:nil];
            ChildrenProductView * view = [nib objectAtIndex:0];
            view.tag = i + 500;
            view.favouriteBtn.tag = i;
            view.backgroundColor = [UIColor clearColor];
            view.titleLab.textColor = color_2;
            //        view.frame = CGRectMake( 5 + 26*(i + 1) + (rect.size.height-10 - 182)/6*i, tapView.frame.size.height + tapView.frame.origin.y + 35 + 282.5 + 37, (rect.size.height-10 - 182)/6, 185);yuan
            
            view.frame = CGRectMake( 5 + 26*(i + 1) + (rect.size.height-10 - 182)/6*i, tapView.frame.size.height + tapView.frame.origin.y + 35 + 282.5 + 37 + 30, 135, 222);
            
            //        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 1*(i + 1) + (rect.size.height-10 - 182)/6*i, tapView.frame.size.height + tapView.frame.origin.y + 35 + 282.5 + 37 + 30, 162, 222)];
            //        imgView.image = [UIImage imageNamed:@"book_Selected.png"];
            
            //        view.frame = CGRectMake( 16,0, 135, 222);
            //        [imgView addSubview:view];
            [self.view addSubview:view];
            [view setHidden:YES];
        }
    }
    

    now=[[NoWifiView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    now.delegate=self;
    [self.view addSubview:now];
    now.hidden=YES;
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[user objectForKey:@"fistInfo_cache"];
    if ([Commonality isEnableWIFI]==0&&dic==nil) {
        now.hidden=YES;
        return;
    }else if([Commonality isEnableWIFI]==0&&dic!=nil){
        
        
        IndexFeaturedHomeModel * homeModel = [[IndexFeaturedHomeModel alloc] initWithDictionary:dic];
        
        for (int i = 0; i < homeModel.ads.count; i++) {
            adModel * ad = [homeModel.ads objectAtIndex:i];
            [_adArr addObject:ad];
        }
        for (int i = 0; i < homeModel.childrenList.count; i++) {
            contentModel * content = [homeModel.childrenList objectAtIndex:i];
            [_childrenArr addObject:content];
        }
        [self loadUI];
        
    }else{
        activit=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activit.frame=CGRectMake(carousel.frame.size.width/2-20, carousel.frame.size.height/2-20, 0, 0);
//        [carousel addSubview:activit];
        [activit startAnimating];
    }
    
    activit=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activit.frame=CGRectMake(self.view.frame.size.height/2-50, self.view.frame.size.width/2-50, 100, 100);
    [self.view addSubview:activit];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(CollectChanged) name:NSNotificationCenter_CollectChanged object:nil];
}

-(void)CollectChanged
{
    [self markHomeRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.userInteractionEnabled = YES;
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[user objectForKey:@"fistInfo_cache"];
    NSDictionary * adDic = [user objectForKey:@"fistInfo_cache_ad"];
    if ((![Commonality isEnableWIFI])&&dic==nil){
//    if (dic==nil) {
        now.hidden= YES;
        return;
    }
    
    
    if (_isPlayBack) {
        _isPlayBack = NO;
        return;
    }
    
    if ([Commonality isEnableWIFI]) {
        [activit startAnimating];
        [self markHomeRequest];
    }
    else{
        if (dic!=nil) {
            
            IndexFeaturedHomeModel * homeModel = [[IndexFeaturedHomeModel alloc] initWithDictionary:dic];
            
            if (_adArr) {
                [_adArr removeAllObjects];
            }
            AdListModel * adlist = [[AdListModel alloc] initWithDictionary:adDic withArr:_adArr];
            if (adlist.result == 0) {
                
            }
            
            
            if (_childrenArr) {
                [_childrenArr removeAllObjects];
            }
            for (int i = 0; i < homeModel.childrenList.count; i++) {
                contentModel * content = [homeModel.childrenList objectAtIndex:i];
                [_childrenArr addObject:content];
            }
            [self loadUI];
            
        }
    }
}

-(void)markHomeRequest
{
    if ([Commonality isEnableWIFI]) {
        NSString* modelStr = [[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"];
        [HttpRequest IndexFeaturedHomeRequestToken:[AppDelegate App].personModel.tokenid deviceDRMId:modelStr delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        [HttpRequest adRequestToken:[AppDelegate App].personModel.tokenid channelCode:@"children" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

#pragma mark EScrollerView
-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    CHECK_NONERETURN(_adArr.count > index);
    adModel * ad = [_adArr objectAtIndex:index];
    
    if ([ad.adType isEqualToString:@"image"]) {
        if (ad.adAnchor) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ad.adAnchor]];
            return;
        }
        
        
        if ([ad.adGuid isEqualToString:@"LOGIN"]){
            if ([AppDelegate App].isLogin == NO) {
//                [Commonality dismissAllView];
                [self clickUserButton:nil];
                return;
            }
            else
            {
                return;
            }
        }
        else if ([ad.adGuid isEqualToString:@"REGISTER"])
        {
            if ([AppDelegate App].isLogin == NO) {
                PersonnalCenter * personView = [AppDelegate App].personView;;
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:personView];
                nav.navigationBarHidden = YES;
                [[AppDelegate App].tabBarController.navigationController pushViewController:personView animated:YES];
                self.view.userInteractionEnabled = YES;
                [personView performSelector:@selector(showMyRegistView) withObject:nil afterDelay:1];
//                [personView showMyRegistView];
                return;
            }
            else
            {
                return;
            }
        }
        else if ([ad.adGuid isEqualToString:@"POSTER"])
        {
            return;
        }
        else
            return;
    }
    
    
    
    
    
    
    self.view.userInteractionEnabled = NO;
    if (![AppDelegate App].isLogin) {
        [self clickUserButton:nil];
//        if ([AppDelegate App].userView == nil) {
//            [AppDelegate App].userView = [[UserView alloc] initMy];
//        }
//        [[AppDelegate App].userView show];
        [Commonality dismissAllView];
        self.view.userInteractionEnabled = YES;
        return;
    }
    _tmpName=ad.adTitle;
    episodeGuid = ad.adGuid;
//    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",ad.adGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",ad.adGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    
}

-(void)showHistory
{
//    
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

#pragma nowWifi Delegate
-(void)callBackClickrech{
//    [HttpRequest indexAdRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    [self markHomeRequest];
    [[AppDelegate App] list];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

#pragma mark -

//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    for (UIView *view in carousel.visibleItemViews){
//        view.alpha = 1.0;
//    }
//    
//    [UIView beginAnimations:nil context:nil];
//    carousel.type = buttonIndex;
//    [UIView commitAnimations];
//    
//}


-(void) GetErr:(ASIHTTPRequest *)request{
    self.view.userInteractionEnabled = YES;
    [activit stopAnimating];
    [Commonality showErrorMsg:self.view type:0 msg:@"网络连接异常，请重试"];
//    if (_isShowingAlartView == NO) {
//        UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接异常，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        alvIew.tag = 502;
//        [alvIew show];
//        _isShowingAlartView = YES;
//    }
}


-(void) GetResult:(ASIHTTPRequest *)request{
//    return;
    [activit stopAnimating];
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        [Commonality showErrorMsg:self.view type:0 msg:@"网络连接异常，请重试"];
    }else{
        if (request.tag == INDEXFEATUREDHOME_TYPE) {
            IndexFeaturedHomeModel * homeModel = [[IndexFeaturedHomeModel alloc] initWithDictionary:dictionary];
            if (homeModel.result == 0) {
//                if (_adArr) {
//                    [_adArr removeAllObjects];
//                }
//                for (int i = 0; i < homeModel.ads.count; i++) {
//                    adModel * ad = [homeModel.ads objectAtIndex:i];
//                    [_adArr addObject:ad];
//                }
                
                if (_childrenArr) {
                    [_childrenArr removeAllObjects];
                }
                
                for (int i = 0; i < homeModel.childrenList.count; i++) {
                    contentModel * content = [homeModel.childrenList objectAtIndex:i];
                    [_childrenArr addObject:content];
                }
                [self loadUI];

                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:dictionary forKey:@"fistInfo_cache"];
                [user synchronize];
                
            }
            else
            {
                [Commonality showErrorMsg:self.view type:homeModel.result msg:@"网络连接异常，请重试"];
            }
        }
        
        if (request.tag==INDEXALLAD_TYPE) {
            if (_adArr) {
                [_adArr removeAllObjects];
            }
            AdListModel * adlist = [[AdListModel alloc] initWithDictionary:dictionary withArr:_adArr];
            if (adlist.result == 0) {
                [self loadUI];
                
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:dictionary forKey:@"fistInfo_cache_ad"];
                [user synchronize];
            }
            else
            {
                [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
            }
        }else if (request.tag==PLAYEVEDIO_type){
            self.view.userInteractionEnabled = YES;
            ProductPlayModel*url=[[ProductPlayModel alloc]initWithDictionary:dictionary];
            if (url.result==0) {
                ProductPlayModel*url=[[ProductPlayModel alloc]initWithDictionary:dictionary];
                if (url.result==0) {
                    NSString*str=nil;
                    if (url.URI.length>1.0) {
                        str=url.URI;
                    }else{
                        str=url.catchupURI;
                    }
        
                    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:playTime];
                    if (_gather) {
                        _gather = nil;
                    }
                    _gather = [[GatherView alloc] initMy:nil];
                    _gather.isMain = YES;
                    _gather.favContEntGuid = episodeGuid;
                    
                }else{
                    
                    [Commonality showErrorMsg:self.view type:url.result msg:@"网络连接异常，请重试"];
                    
                }
                
            }else{
                
                if (url.result == 204) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"会员权限未开通或已过期" message:@"请先开通会员！" delegate:self cancelButtonTitle:@"稍后开通" otherButtonTitles:@"立即开通", nil];
                    [alert show];
                    return;
                }
                [Commonality showErrorMsg:self.view type:url.result msg:@"网络连接异常，请重试"];
                
            }
        }
        else if (request.tag == USERPREFERRNCE_GET_TYPE)
        {
            UserPreferenceModel * userPreferModel = [[UserPreferenceModel alloc] initWithDictionary:dictionary];
            if (userPreferModel.result == 0) {
                if (![Commonality isEmpty:userPreferModel.preferenceValue]) {
                    NSArray * arr1 = [userPreferModel.preferenceValue componentsSeparatedByString:@"."];
                    if (arr1.count ==2) {
                        playTime = [[arr1 lastObject] intValue];
                    }
                    else
                    {
                        playTime = 0;
                    }
                }
                else
                {
                    playTime = 0;
                }
                [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:episodeGuid startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
            else
            {
                [Commonality showErrorMsg:self.view type:userPreferModel.result msg:LINGKERROR];
            }
            
        
        }
        else if (request.tag == ADLIST_TYPE)
        {
            if (_adArr) {
                [_adArr removeAllObjects];
            }
            AdListModel * adlist = [[AdListModel alloc] initWithDictionary:dictionary withArr:_adArr];
            if (adlist.result == 0) {
                [self loadUI];
                
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:dictionary forKey:@"fistInfo_cache_ad"];
                [user synchronize];
            }
            else
            {
                [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
            }
        }
        
    }
}

-(void)loadUI
{
    if (_imgArr) {
        [_imgArr removeAllObjects];
    }
    if (_titleArr) {
        [_titleArr removeAllObjects];
    }
    
    for (int i = 0; i < _adArr.count; i++) {
        adModel * ad = [_adArr objectAtIndex:i];
        [_imgArr addObject:ad.adImg];
        [_titleArr addObject:ad.adTitle];
    }
    
    if (adscrollerView) {
        [adscrollerView removeFromSuperview];
        adscrollerView = nil;
    }
    
    CHECK_NONERETURN(_imgArr.count > 0);
    CHECK_NONERETURN(_titleArr.count > 0);


//    adscrollerView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(100, 118 + 20, rect.size.height - 200, 216) ImageArray:_imgArr TitleArray:_titleArr VipArray:nil];
    adscrollerView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(71.5, 9, 742, 216) ImageArray:_imgArr TitleArray:_titleArr VipArray:nil];
    adscrollerView.delegate = self;
    
//    [Commonality setImgViewStyle:adscrollerView];
//    [self.view addSubview:adscrollerView];
    
    if (adBackgroundView == nil) {
        adBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(68, 118, 888, 270)];
        adBackgroundView.image = [UIImage imageNamed:@"banner_bg.png"];
        adBackgroundView.userInteractionEnabled = YES;
        adscrollerView.userInteractionEnabled = YES;
        [self.view addSubview:adBackgroundView];
//        [Commonality setImgViewStyle:adBackgroundView];
    }
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0,adBackgroundView.frame.size.width -34, 265)];
    imageView1.image = [UIImage imageNamed:@"CloudCoverage.png"];
    
    [adBackgroundView addSubview:imageView1];
    [adBackgroundView addSubview:adscrollerView];
    
    
    for (int i = 0; i < 6; i++) {
        UIView * view = [self.view viewWithTag:i + 500];
        if ([view isKindOfClass:[ChildrenProductView class]]) {
            [view setHidden:NO];
            ChildrenProductView * view1 = (ChildrenProductView *)view;
            CHECK_NONERETURN(_childrenArr.count > i);
                contentModel * content = [_childrenArr objectAtIndex:i];
                [view1.image setImageWithURL:[NSURL URLWithString:content.contentImg] placeholderImage:[UIImage imageNamed:@"videoBackground.png"]];            
            
                view1.titleLab.text = content.contentTitle;
                view1.contentGuid = content.contentGuid;
                view1.contentType = content.contentType;
                if (content.isCollect == 0) {
                    view1.isCollect = 0;
                    [view1.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec.png"] forState:(UIControlStateNormal)];
                }
                else
                {
                    view1.isCollect = 1;
                    [view1.favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec2.png"] forState:(UIControlStateNormal)];
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
    pro.productId = productID;
    pro.isShowFromMain = YES;
    [pro show];
}

//- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
//    return wrap;
//}


-(void)clickUserButton:(UIButton*)sender{

//    [Commonality clickUserBtn];
    
    PersonnalCenter * personView = [AppDelegate App].personView;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:personView];
    nav.navigationBarHidden = YES;
    [[AppDelegate App].tabBarController.navigationController pushViewController:personView animated:YES];
    self.view.userInteractionEnabled = YES;
//    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
//    [myTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)iPadPlayerCallBack:(iPadPlayerCallBackEventType)callBackEventType withParameter:(NSMutableDictionary *)callBackInfo
{

    int time = [[callBackInfo objectForKey:@"time"] intValue];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",episodeGuid] preferenceValue:[NSString stringWithFormat:@"1.%d",time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    //    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",episodeGuid] preferenceValue:[NSString stringWithFormat:@"1.%d",time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

@end
