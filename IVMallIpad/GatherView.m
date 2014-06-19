//
//  GatherView.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "GatherView.h"
#import "UIButton+Bootstrap.h"
#import "HttpRequest.h"
#import "Commonality.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "ProductPlayModel.h"
#import "CustomTabBarCtl.h"
#import "ChildrenViewController.h"
#import "Recommend8View.h"
#import "ProgramPackage.h"
#import "UserPreferenceModel.h"
#import "MainViewController.h"


static UIButton *selectBut;
#define degreesToRadian(x) (M_PI * (x) / 180.0)
@implementation GatherView
@synthesize towBackView=towBackView;


-(id) initMy:(id)className{
    if (self=[super init]) {
//        [IVMallPlayer sharedIVMallPlayer].delegate = self;
        
        self.myCatcontent=(ChannelCatContentListModel*)className;
        
        if ([IVMallPlayer sharedIVMallPlayer].delegate) {
            [IVMallPlayer sharedIVMallPlayer].delegate = nil;
            
        }
        [IVMallPlayer sharedIVMallPlayer].delegate = self;
        
        _isPlayEndBack = NO;
        _isGetResult = NO;
        _isPlayVied = NO;
        _isMain = NO;
        currentPlayingIndex = -1;
        _currentSelectedProgramTime = 0;
        rect=[[UIScreen mainScreen]bounds];

        
        UIViewController * main = [AppDelegate App].tabBarController;

        self.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _tableArray=[[NSMutableArray alloc]init];
//        self.transform = CGAffineTransformMakeRotation(90 * (M_PI / 180.0f));
        UIImageView*backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.height, rect.size.width)];
        backImageView.backgroundColor=[UIColor blackColor];
        backImageView.alpha=0.5;
        backImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired=1;
        [backImageView addGestureRecognizer:tap];
        [self addSubview:backImageView];
        
        towBackView=[[UIView alloc]init];
//        towBackView.frame=CGRectMake(250, 100, rect.size.height-500-20, 560.5);
        towBackView.frame=CGRectMake(200, 100, [AppDelegate App].tabBarController.customContentView.frame.size.width - 400, 560.5 + 50);
        NSLog(@"rect.size.height-500-20 is %f",rect.size.height-500-20);
        towBackView.backgroundColor=[UIColor clearColor];
        towBackView.clipsToBounds=YES;
        towBackView.layer.cornerRadius=5;
        
        backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 50, towBackView.frame.size.width + 20, towBackView.frame.size.height + 30)];
//        backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 70, towBackView.frame.size.width + 20, towBackView.frame.size.height + 30)];
        backgroundImgView.image = [UIImage imageNamed:@"SeriesBox.png"];
        [self addSubview:backgroundImgView];


//        [Commonality setImgViewStyle:towBackView];
        backButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.backgroundColor=[UIColor clearColor];
        [backButton setBackgroundImage:[UIImage imageNamed:@"X.png"] forState:(UIControlStateNormal)];
        backButton.frame=CGRectMake(20, 10, 30, 30 );
        backButton.layer.cornerRadius=20;
        [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [towBackView addSubview:backButton];
        
//        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 60, (towBackView.frame.size.width-100)/3, 170)];
//        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 60, 113, 170)];
        
        
//        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 60, 139, 185)];
        
        
        
        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(30 + 12 - 7, 60 - 10, 86, 114.5)];
//        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(12 + 30, 60, 110, 146.5)];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.clipsToBounds=YES;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVied)];
        tap2.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap2];
        [towBackView addSubview:imgView];
        
        UIImageView * backImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(30 - 7, 65 - 10, 110 , 129)];
//        UIImageView * backImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(30, 70, 110 + 24, 160)];
        backImageView1.image = [UIImage imageNamed:@"CloudCoverage3.png"];
        [towBackView addSubview:backImageView1];
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+imgView.frame.size.width+20, imgView.frame.origin.y-5 + 8, 250, 30)];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.font=[UIFont boldSystemFontOfSize:18];
        [towBackView addSubview:titleLabel];
        
        orlabe=[[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height, 150, 30)];
        orlabe.font=[UIFont boldSystemFontOfSize:13];
        orlabe.backgroundColor=[UIColor clearColor];
        [towBackView addSubview:orlabe];
        
        UIImageView*playimg=[[UIImageView alloc]initWithFrame:CGRectMake(orlabe.frame.origin.x, orlabe.frame.origin.y+orlabe.frame.size.height+3,10, 10)];
        playimg.image=[UIImage imageNamed:@"RecordJJ.png"];
        [towBackView addSubview:playimg];
        
        
        playCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(orlabe.frame.origin.x+playimg.frame.size.width, orlabe.frame.origin.y+orlabe.frame.size.height, 100, 20)];
        playCountLabel.font=[UIFont boldSystemFontOfSize:13];
        playCountLabel.backgroundColor=[UIColor clearColor];
        [towBackView addSubview:playCountLabel];
        
        
        UIImageView*favimg=[[UIImageView alloc]initWithFrame:CGRectMake(playCountLabel.frame.origin.x+playCountLabel.frame.size.width+10 - 40, playimg.frame.origin.y,10, 10)];
        favimg.image=[UIImage imageNamed:@"CollectionJJ.png"];
        [towBackView addSubview:favimg];
        
        favCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(favimg.frame.origin.x+favimg.frame.size.width+3, playCountLabel.frame.origin.y, 100, 20)];
        favCountLabel.backgroundColor=[UIColor clearColor];
        favCountLabel.font=[UIFont boldSystemFontOfSize:13];
        [towBackView addSubview:favCountLabel];
        
        
        lastPlayTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(playCountLabel.frame.origin.x - 10, 10+imgView.frame.size.height-37.5 + 2, 200, 25)];
        lastPlayTimeLab.textColor = [UIColor blackColor];
        lastPlayTimeLab.alpha = 0.6;
        lastPlayTimeLab.backgroundColor = [UIColor clearColor];
        lastPlayTimeLab.font = [UIFont boldSystemFontOfSize:13];
        [towBackView addSubview:lastPlayTimeLab];
        
        playeButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [playeButton setTitle:@"播放" forState:(UIControlStateNormal)];
        [playeButton addTarget:self action:@selector(playVied) forControlEvents:UIControlEventTouchUpInside];
        playeButton.frame=CGRectMake(playCountLabel.frame.origin.x - 10, 20+imgView.frame.size.height-37.5 + 37.5 + 2 + 5 , 105, 37.5);
//        85
//        37.5
//        [playeButton redStyle];
        playeButton.backgroundColor = color_4;
        [playeButton childrenBtnStyleForBtn:playeButton];
//        UIView * view = [Commonality makeButtonShadowViewWhitbtn:playeButton];
//        [towBackView addSubview:view];
        
        _favButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_favButton addTarget:self action:@selector(clickFavButton) forControlEvents:(UIControlEventTouchUpInside)];
        _favButton.frame=CGRectMake(playeButton.frame.origin.x+playeButton.frame.size.width+20, playeButton.frame.origin.y + 3, 37.5, 37.5);
//        37.5
//        _favButton.layer.borderWidth=0.8;
        _favButton.layer.cornerRadius=18.75;
//        _favButton.layer.borderColor=[Commonality colorFromHexRGB:@"cccccc"].CGColor;
        
        UIView * view = [Commonality makeButtonShadowViewWhitbtn:playeButton];
        [towBackView addSubview:view];
        [towBackView addSubview:_favButton];
        
        UIView*lingView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, towBackView.frame.size.width, 0.5)];
        lingView.backgroundColor=color_18;
        [towBackView addSubview:lingView];
        
        NSArray* langArray = [NSArray array];
        if ([self.myCatcontent.langs length]) {
            langArray = [self.myCatcontent.langs componentsSeparatedByString:@","];
        }
        if ([langArray count] == 2) {
            UIButton*epBUtton1=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [epBUtton1 setTitle:@"剧集列表（中文版）" forState:(UIControlStateNormal)];
            epBUtton1.frame=CGRectMake(0, lingView.frame.origin.y+ -36 , towBackView.frame.size.width/3, 33);
            [epBUtton1 setTitleColor:color_4 forState:(UIControlStateNormal)];
            [epBUtton1 addTarget:self action:@selector(clickVideo1) forControlEvents:UIControlEventTouchUpInside];
            epBUtton1.titleLabel.font = font_5;
            epBUtton1.backgroundColor=[UIColor clearColor];
            epBUtton1.tag = 700;
            [towBackView addSubview:epBUtton1];
            
            _backLianView1=[[UIView alloc]initWithFrame:CGRectMake(epBUtton1.frame.origin.x, lingView.frame.origin.y-3, epBUtton1.frame.size.width, 3)];
            _backLianView1.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
            [towBackView addSubview:_backLianView1];
            
            UIButton*epBUtton2=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [epBUtton2 setTitle:@"剧集列表（英文版）" forState:(UIControlStateNormal)];
            epBUtton2.frame=CGRectMake(epBUtton1.frame.size.width+epBUtton1.frame.origin.x+10, lingView.frame.origin.y+ -36 , towBackView.frame.size.width/3, 33);
            [epBUtton2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [epBUtton2 addTarget:self action:@selector(clickVideo2) forControlEvents:UIControlEventTouchUpInside];
            epBUtton2.titleLabel.font = font_5;
            epBUtton2.backgroundColor=[UIColor clearColor];
            epBUtton2.tag = 701;
            [towBackView addSubview:epBUtton2];
            
            _backLianView2=[[UIView alloc]initWithFrame:CGRectMake(epBUtton2.frame.origin.x, lingView.frame.origin.y-3, epBUtton2.frame.size.width, 3)];
            _backLianView2.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
            [towBackView addSubview:_backLianView2];
            
            
            UIButton*descButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
            descButton.frame=CGRectMake(epBUtton2.frame.size.width+epBUtton2.frame.origin.x+10, epBUtton2.frame.origin.y, epBUtton2.frame.size.width, epBUtton2.frame.size.height);
            [descButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            descButton.alpha = alpha_4;
            descButton.titleLabel.font = font_5;
            [descButton addTarget:self action:@selector(clickdesc) forControlEvents:UIControlEventTouchUpInside];
            [descButton setTitle:@"视频介绍" forState:(UIControlStateNormal)];
            descButton.tag = 702;
            [towBackView addSubview:descButton];
            
            _backLianView3=[[UIView alloc]initWithFrame:CGRectMake(descButton.frame.origin.x, lingView.frame.origin.y-3, epBUtton2.frame.size.width, 3)];
            _backLianView3.backgroundColor=[UIColor clearColor];
            [towBackView addSubview:_backLianView3];
        }else{
            UIButton*epBUtton=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [epBUtton setTitle:@"剧集列表" forState:(UIControlStateNormal)];
            epBUtton.frame=CGRectMake(0, lingView.frame.origin.y+ -36 , towBackView.frame.size.width/2, 33);
            [epBUtton setTitleColor:color_4 forState:(UIControlStateNormal)];
            [epBUtton addTarget:self action:@selector(clickVideo1) forControlEvents:UIControlEventTouchUpInside];
            epBUtton.titleLabel.font = font_5;
            epBUtton.backgroundColor=[UIColor clearColor];
            epBUtton.tag = 700;
            [towBackView addSubview:epBUtton];
            
            _backLianView1=[[UIView alloc]initWithFrame:CGRectMake(epBUtton.frame.origin.x, lingView.frame.origin.y-3, epBUtton.frame.size.width, 3)];
            _backLianView1.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
            [towBackView addSubview:_backLianView1];
            
            UIButton*descButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
            descButton.frame=CGRectMake(epBUtton.frame.size.width+epBUtton.frame.origin.x+10, epBUtton.frame.origin.y, epBUtton.frame.size.width, epBUtton.frame.size.height);
            [descButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            descButton.alpha = alpha_4;
            descButton.titleLabel.font = font_5;
            [descButton addTarget:self action:@selector(clickdesc) forControlEvents:UIControlEventTouchUpInside];
            [descButton setTitle:@"视频介绍" forState:(UIControlStateNormal)];
            descButton.tag = 701;
            [towBackView addSubview:descButton];
            
            _backLianView2=[[UIView alloc]initWithFrame:CGRectMake(descButton.frame.origin.x, lingView.frame.origin.y-3, epBUtton.frame.size.width, 3)];
            _backLianView2.backgroundColor=[UIColor clearColor];
            [towBackView addSubview:_backLianView2];
        }
        
        
        
        _myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, lingView.frame.origin.y+1, towBackView.frame.size.height, 40)];
        _myScrollView.backgroundColor=[UIColor clearColor];
        _myScrollView.showsHorizontalScrollIndicator=NO;
        _myScrollView.pagingEnabled = YES;
        [towBackView addSubview:_myScrollView];
        
////        _myScrollView.frame.size.width/4/2 - 15
//        indicatorImage = [[UIImageView alloc] initWithFrame:CGRectMake(300, 150, 66, 30)];
//        indicatorImage.image = [UIImage imageNamed:@"Arrow.png"];
//        indicatorImage.backgroundColor= [UIColor clearColor];
//        [towBackView addSubview:indicatorImage];
        
        view1=[[UIView alloc]initWithFrame:CGRectMake(0, lingView.frame.origin.y+41, towBackView.frame.size.width, 10)];
        view1.backgroundColor=[UIColor clearColor];
        
//        UIView*lingView1=[[UIView alloc]initWithFrame:CGRectMake(0,0.5, towBackView.frame.size.width, 0.5)];
//        lingView1.backgroundColor=[Commonality colorFromHexRGB:@"cccccc"];
//        [view1 addSubview:lingView1];
        
        [towBackView addSubview:view1];
        
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, lingView.frame.origin.y+51, towBackView.frame.size.width, towBackView.frame.size.height-lingView.frame.origin.y-51-12)];
        _tabelView.backgroundColor=[UIColor clearColor];
        _tabelView.bounces=YES;
        _tabelView.separatorStyle=NO;
        _tabelView.dataSource=self;
        _tabelView.delegate=self;
        [towBackView addSubview:_tabelView];
        
        view2=[[UIView alloc]initWithFrame:CGRectMake(0, _tabelView.frame.origin.y+_tabelView.frame.size.height, towBackView.frame.size.width, 15)];
        view2.backgroundColor=[UIColor clearColor];
        [towBackView addSubview:view2];
        [self addSubview:towBackView];
        
        _decLabel=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.origin.x, lingView.frame.origin.y+5 + 50, towBackView.frame.size.width-imgView.frame.origin.x*2, towBackView.frame.size.height-100)];
        _decLabel.numberOfLines=0;
        _decLabel.font=[UIFont systemFontOfSize:15];
        _decLabel.backgroundColor=[UIColor clearColor];
       
        [towBackView addSubview:_decLabel];
        _decLabel.hidden=YES;
        backCent=towBackView.center;
        
        activit=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activit.frame=CGRectMake(_tabelView.frame.size.width/2-20, _tabelView.frame.size.height/2-20, 50, 50);
//        activit.frame = CGRectMake(towBackView.frame.origin.x, towBackView.frame.origin.y + 50, towBackView.frame.size.width, towBackView.frame.size.height - 50);
//        activit.frame = towBackView.frame;
        activit.backgroundColor = [UIColor clearColor];
        [_tabelView addSubview:activit];

    }
    return self;
}

-(void)clickdesc{
    NSArray* langArray = [self.myCatcontent.langs componentsSeparatedByString:@","];
    if ([langArray count]==2) {
        UIButton * btn = (UIButton *)[towBackView viewWithTag:700];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        btn = (UIButton *)[towBackView viewWithTag:701];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        UIButton * btn1 = (UIButton *)[towBackView viewWithTag:702];
        if (btn1) {
            btn1.alpha = 1;
            [btn1 setTitleColor:color_4 forState:(UIControlStateNormal)];
        }
        _backLianView3.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
        _backLianView1.backgroundColor=[UIColor clearColor];
        _backLianView2.backgroundColor=[UIColor clearColor];
        _decLabel.hidden=NO;
        _tabelView.hidden=YES;
        _myScrollView.hidden=YES;
        view1.hidden=YES;
        view2.hidden=YES;
        _tabelView.userInteractionEnabled=YES;
    }else{
        UIButton * btn = (UIButton *)[towBackView viewWithTag:700];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        UIButton * btn1 = (UIButton *)[towBackView viewWithTag:701];
        if (btn1) {
            btn1.alpha = 1;
            [btn1 setTitleColor:color_4 forState:(UIControlStateNormal)];
        }
        _backLianView2.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
        _backLianView1.backgroundColor=[UIColor clearColor];
        _decLabel.hidden=NO;
        _tabelView.hidden=YES;
        _myScrollView.hidden=YES;
        view1.hidden=YES;
        view2.hidden=YES;
        _tabelView.userInteractionEnabled=YES;
    }
}

-(void)clickVideo1{
    NSArray* langArray = [self.myCatcontent.langs componentsSeparatedByString:@","];
    if ([langArray count] == 2)
    {
        UIButton * btn = (UIButton *)[towBackView viewWithTag:701];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        btn = (UIButton *)[towBackView viewWithTag:702];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        btn = (UIButton *)[towBackView viewWithTag:700];
        if (btn) {
            btn.alpha = 1;
            [btn setTitleColor:color_4 forState:(UIControlStateNormal)];
        }
        _backLianView1.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
        _backLianView2.backgroundColor=[UIColor clearColor];
        _backLianView3.backgroundColor=[UIColor clearColor];
        _decLabel.hidden=YES;
        _tabelView.hidden=NO;
        _myScrollView.hidden=NO;
        view1.hidden=NO;
        view2.hidden=NO;
        _tabelView.userInteractionEnabled=YES;
        
        [HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:self.myCatcontent.contentGuid lang:@"zh-cn" page:1 rows:1000 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        UIButton * btn = (UIButton *)[towBackView viewWithTag:701];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        UIButton * btn1 = (UIButton *)[towBackView viewWithTag:700];
        if (btn1) {
            btn1.alpha = 1;
            [btn1 setTitleColor:color_4 forState:(UIControlStateNormal)];
        }
        _backLianView1.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
        _backLianView2.backgroundColor=[UIColor clearColor];
        _decLabel.hidden=YES;
        _tabelView.hidden=NO;
        _myScrollView.hidden=NO;
        view1.hidden=NO;
        view2.hidden=NO;
        _tabelView.userInteractionEnabled=YES;
    }
}
-(void)clickVideo2{
    NSArray* langArray = [self.myCatcontent.langs componentsSeparatedByString:@","];
    if ([langArray count] == 2)
    {
        UIButton * btn = (UIButton *)[towBackView viewWithTag:700];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        btn = (UIButton *)[towBackView viewWithTag:702];
        if (btn) {
            btn.alpha = alpha_4;
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        btn = (UIButton *)[towBackView viewWithTag:701];
        if (btn) {
            btn.alpha = 1;
            [btn setTitleColor:color_4 forState:(UIControlStateNormal)];
        }
        _backLianView2.backgroundColor=[Commonality colorFromHexRGB:MANETIONCOLOL];
        _backLianView1.backgroundColor=[UIColor clearColor];
        _backLianView3.backgroundColor=[UIColor clearColor];
        _decLabel.hidden=YES;
        _tabelView.hidden=NO;
        _myScrollView.hidden=NO;
        view1.hidden=NO;
        view2.hidden=NO;
        _tabelView.userInteractionEnabled=YES;
        
        [HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:self.myCatcontent.contentGuid lang:@"en-gb" page:1 rows:1000 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    
    // zjj
    int count=0;
    int number = _tableArray.count - (self.myPage-1)*90;
    if (number > 90) {
        number = 90;
    }
    if (number%9!=0) {
        count=1;
    }
    return number/9+count;
    //zjj
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=NO;
//    }
    
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//    cell.backgroundColor=[UIColor clearColor];
//    cell.selectionStyle=NO;
    
//zjj
    int number = _tableArray.count - (self.myPage-1)*90;
    if (number > 90) {
        number = 90;
    }
//zjj
    for (int i=0; i<9; i++) {
        if (number>9*indexPath.row+i) {
            UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];

            button.tag = (self.myPage-1)*90+indexPath.row*9+i+1;

            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//            button.layer.borderColor=[Commonality colorFromHexRGB:@"bdbdbd"].CGColor;
//            button.layer.borderWidth=1;
            
            [button addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[NSString stringWithFormat:@"%i",(self.myPage-1)*90+indexPath.row*9+i+1] forState:(UIControlStateNormal)];
            button.titleLabel.font=[UIFont systemFontOfSize:13];
            button.frame=CGRectMake(10*(i+1)+(_tabelView.frame.size.width-90)/10*i+15, 5, 40, 40);
            
            NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
            
            NSArray * arr = [user objectForKey:[NSString stringWithFormat:@"children_IsPlay%@",selfContentGuid]];
            
            if (arr.count == 0) {
                [button setBackgroundImage:[Commonality imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            }
            else
            {
                CHECK_RETURN_CELL(arr.count > button.tag-1, cell);
                if ([[arr objectAtIndex:button.tag-1] isEqualToString:@"0"]) {
//                    Series_buttom (3).png
//                    [button setBackgroundImage:[Commonality imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                    [button setBackgroundImage:[UIImage imageNamed:@"Series_buttom3.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [button setBackgroundImage:[UIImage imageNamed:@"Series_Button.png"] forState:UIControlStateNormal];
//                    [button setBackgroundImage:[Commonality imageFromColor:[Commonality colorFromHexRGB:@"ececec"]] forState:UIControlStateNormal];
                }
            }

            
            [user synchronize];
            
            
//            if (cont.oldPlay==YES) {
//                [button setBackgroundImage:[Commonality imageFromColor:[Commonality colorFromHexRGB:@"ececec"]] forState:UIControlStateNormal];
//            }else{
//                [button setBackgroundImage:[Commonality imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//            }
            [button setTitleColor:[Commonality colorFromHexRGB:MANETIONCOLOL] forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage imageNamed:@"Series_buttom2.png"] forState:UIControlStateHighlighted];
//            [button setBackgroundImage:[Commonality imageFromColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
            
            
            button.layer.cornerRadius = 20;
//            button.layer.borderWidth = 1;
//            button.layer.borderColor = [color_18 CGColor];
            button.layer.masksToBounds = YES;
            
//            [button childrenCircleBtnStyle];
//            UIView * backView = [Commonality makeButtonShadowViewWhitbtn:button];
            [cell addSubview:button];
            
        }
    }
    return cell;
    
}



-(void)clickFavButton{
    
    if (_isGetResult == NO) {
        return;
    }
    if (![AppDelegate App].isLogin) {
        MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        [main clickUserButton:nil];
        return;
    }
    _favButton.userInteractionEnabled = NO;
    if (self.myCatcontent==nil) {
        if (self.myEpisode.isCollect1==0) {
            favCountLabel.text=[NSString stringWithFormat:@"%i",favCountLabel.text.intValue+1];
            self.myEpisode.isCollect1=1;
            _myCatcontent.favoriteCount += 1;
            [self.favButton setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
            [HttpRequest addFavorRequest:[AppDelegate App].personModel.tokenid contentGiud:self.myEpisode.contentGuid1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }else{
            int a = favCountLabel.text.intValue-1;
            if (a >= 0) {
                favCountLabel.text=[NSString stringWithFormat:@"%i",favCountLabel.text.intValue-1];
            }
            _myCatcontent.favoriteCount -= 1;
            [self.favButton setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
            self.myEpisode.isCollect1=0;
            [HttpRequest caelFavorWithConteng:[AppDelegate App].personModel.tokenid contentGiud:self.myEpisode.contentGuid1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
    }else{
        self.favButton.tag = self.myCatcontent.modelTag;
        if (_delegate1 && [_delegate1 respondsToSelector:@selector(changeFavouriteCount:)]) {
            [_delegate1 changeFavouriteCount:self.favButton];
        }
        
        if (self.myCatcontent.isCollect==0) {
            favCountLabel.text=[NSString stringWithFormat:@"%i",favCountLabel.text.intValue+1];
            self.myCatcontent.isCollect=1;
            _myCatcontent.favoriteCount += 1;
            [self.favButton setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
            [HttpRequest addFavorRequest:[AppDelegate App].personModel.tokenid contentGiud:_myCatcontent.contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }else{
            
            int a = favCountLabel.text.intValue-1;
            if (a >= 0) {
                favCountLabel.text=[NSString stringWithFormat:@"%i",favCountLabel.text.intValue-1];
            }
            _myCatcontent.favoriteCount -= 1;
            [self.favButton setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
            self.myCatcontent.isCollect=0;
            [HttpRequest caelFavorWithConteng:[AppDelegate App].personModel.tokenid contentGiud:_myCatcontent.contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
    }
}

-(void)clickPlay:(UIButton*)sender{
    _isPlayVied = NO;
    if (_isGetResult == NO) {
        return;
    }
    
    if (![AppDelegate App].isLogin) {
        MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        [main clickUserButton:nil];
        return;
    }
    _playBut=sender;
    
    CHECK_NONERETURN(_tableArray.count > sender.tag - 1);
    ContentEpisodeItemListModel*cont=[self.tableArray objectAtIndex:sender.tag-1];
    productID = cont.contentGuid;
    NSArray* langArray = [cont.lang componentsSeparatedByString:@","];
    if ([langArray count] == 2) {
        lang = @"en-gb";
    }else{
        lang = @"zh-cn";
    }
    
//    lang = cont.
    cont.oldPlay=YES;
    
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[user objectForKey:[NSString stringWithFormat:@"children_IsPlay%@",selfContentGuid]]];
    CHECK_NONERETURN(arr.count > sender.tag - 1);
    [arr replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    [user setObject:arr forKey:[NSString stringWithFormat:@"children_IsPlay%@",selfContentGuid]];
    [user synchronize];
    
    currentPlayingIndex = [sender.titleLabel.text intValue];
    
    self.tmpName=cont.contentTitle;
    _tabelView.userInteractionEnabled=NO;
    backButton.userInteractionEnabled = NO;
    
    _isUserPerfernceResult = NO;
    
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
 
}

-(void)playVied{
    
    if (![AppDelegate App].isLogin) {
        MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        [main clickUserButton:nil];
        return;
    }
    
    _isPlayVied = YES;
    if (_isGetResult == NO) {
        return;
    }
    if ([AppDelegate App].isLogin==NO) {
        [Commonality dismissAllView];
      
        return;
    }
    if (![Commonality isEnableWIFI]) {
        [Commonality showErrorMsg:towBackView type:0 msg:@"网络连接异常，请重试"];
        return;
    }
    
    if (currentPlayingIndex < 1) {
        currentPlayingIndex = 1;
    }
    
    CHECK_NONERETURN(self.tableArray.count > currentPlayingIndex - 1);
    ContentEpisodeItemListModel*cont=[self.tableArray objectAtIndex:currentPlayingIndex - 1];
    UIButton * btn = (UIButton*)[_tabelView viewWithTag:currentPlayingIndex];
    _playBut = btn;
    if ([Commonality isEmpty:cont.contentGuid]) {
        return;
    }
//    if ([self.tableArray count]==0) {
//        self.tmpName=self.myCatcontent.contentTitle;
//        
//        [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:_myCatcontent.contentGuid startTime:@"" endTime:@"" ipAddr:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//        return;
//    }
    imgView.userInteractionEnabled = NO;
    playeButton.userInteractionEnabled = NO;
    backButton.userInteractionEnabled = NO;
    _tabelView.userInteractionEnabled = NO;
    CHECK_NONERETURN(self.tableArray.count > 0);
    
    self.tmpName=cont.contentTitle;
    
    [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:cont.contentGuid startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void) show:(id)classa{
    
//    if ([IVMallPlayer sharedIVMallPlayer].delegate) {
//        [IVMallPlayer sharedIVMallPlayer].delegate = nil;
//        
//    }
//    [IVMallPlayer sharedIVMallPlayer].delegate = self;
    _showFrom = showFromChildren;
    _isMain = NO;
    [activit startAnimating];
    for(UIView *view in [_myScrollView subviews]){
        [view removeFromSuperview];
    }

    [self.tableArray removeAllObjects];
    [self.tabelView reloadData];
    selectBut=nil;
    self.myCatcontent=(ChannelCatContentListModel*)classa;
    NSString*str=self.myCatcontent.contentImg;//[self.myCatcontent.contentImg stringByReplacingOccurrencesOfString:@".jpg" withString:@"-s.jpg"];
    [imgView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"videoBackground.png"]];

    if (self.myCatcontent.isCollect==1) {
        [_favButton setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
    }else{
        [_favButton setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
    }
    _hihel=YES;
    titleLabel.text=self.myCatcontent.contentTitle;
    
    playCountLabel.text=[NSString stringWithFormat:@"%i",self.myCatcontent.playCount];
    favCountLabel.text=[NSString stringWithFormat:@"%i",self.myCatcontent.favoriteCount];
    orlabe.text=[NSString stringWithFormat:@"所属内容频道:%@",self.myCatcontent.contentFrom];
    orlabe.hidden = YES;
    
    _decLabel.text=self.myCatcontent.contentDescription;
    CGSize size = [_decLabel.text sizeWithFont:_decLabel.font constrainedToSize:CGSizeMake(_decLabel.frame.size.width, MAXFLOAT)];
    _decLabel.frame=CGRectMake(_decLabel.frame.origin.x, _decLabel.frame.origin.y, size.width, size.height);
    _decLabel.layer.borderColor=[UIColor clearColor].CGColor;
    _decLabel.layer.borderWidth=0;
    
    [self clickVideo1];
    
    [towBackView setTransform:CGAffineTransformScale(towBackView.transform,0.3,0.35)];
    towBackView.center=[AppDelegate App].selctImgCent;
    [backgroundImgView setTransform:CGAffineTransformScale(backgroundImgView.transform,0.3,0.35)];
    backgroundImgView.center=[AppDelegate App].selctImgCent;
    
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:towBackView cache:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:backgroundImgView cache:YES];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            towBackView.center=backCent;
            backgroundImgView.center = backCent;
            towBackView.transform = CGAffineTransformIdentity;
            backgroundImgView.transform = CGAffineTransformIdentity;
        }];
        
    }];

    
    UIViewController * main = [AppDelegate App].tabBarController;
    [main.view addSubview:self];
//    self.backgroundColor = [UIColor yellowColor];
  
    self.myPage=1;
    [activit startAnimating];
    //zjj
    //[HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:self.myCatcontent.contentGuid page:1 rows:90 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    [HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:self.myCatcontent.contentGuid lang:@"" page:1 rows:1000 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    //zjj
//    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",self.myCatcontent.contentGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",self.myCatcontent.contentGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}



-(void)showFormFav:(NSString*)contEntGuid{
    _showFrom = showFromFavourite;
    _isMain = NO;
    [activit startAnimating];
    for(UIView *view in [_myScrollView subviews]){
        [view removeFromSuperview];
    }
    [self.tableArray removeAllObjects];
    [self.tabelView reloadData];
    selectBut=nil;
    _hihel=YES;
    [self clickVideo1];
    
//    [towBackView setTransform:CGAffineTransformScale(towBackView.transform,0.3,0.35)];
//    towBackView.center=[AppDelegate App].selctImgCent;
//    [UIView animateWithDuration:0 animations:^{
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:towBackView cache:YES];
//    }completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 animations:^{
//            towBackView.center=backCent;
//            towBackView.transform = CGAffineTransformIdentity;
//        }];
//        
//    }];
//    
//    UIViewController * main = [AppDelegate App].tabBarController;
//    [main.view addSubview:self];
//    self.backgroundColor = [UIColor yellowColor];
    self.myPage=1;
    self.myCatcontent=nil;
    _isDelegate = YES;
    
    [towBackView setTransform:CGAffineTransformScale(towBackView.transform,0.3,0.35)];
    towBackView.center=[AppDelegate App].selctImgCent;
    [backgroundImgView setTransform:CGAffineTransformScale(backgroundImgView.transform,0.3,0.35)];
    backgroundImgView.center=[AppDelegate App].selctImgCent;
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:towBackView cache:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:backgroundImgView cache:YES];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            towBackView.center=backCent;
            backgroundImgView.center = backCent;
            towBackView.transform = CGAffineTransformIdentity;
            backgroundImgView.transform = CGAffineTransformIdentity;
        }];
        
    }];
    
    [HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:contEntGuid lang:@"" page:1 rows:90 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    _favContEntGuid = contEntGuid;
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",contEntGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}


-(void)showFormMain:(NSString*)contEntGuid{
    _showFrom = showFromMain;
    _isMain = NO;
    [activit startAnimating];
    for(UIView *view in [_myScrollView subviews]){
        [view removeFromSuperview];
    }
    [self.tableArray removeAllObjects];
    [self.tabelView reloadData];
    selectBut=nil;
    _hihel=YES;
    [self clickVideo1];
    
    [towBackView setTransform:CGAffineTransformScale(towBackView.transform,0.3,0.35)];
    towBackView.center=[AppDelegate App].selctImgCent;
    [backgroundImgView setTransform:CGAffineTransformScale(backgroundImgView.transform,0.3,0.35)];
    backgroundImgView.center=[AppDelegate App].selctImgCent;
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:towBackView cache:YES];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            towBackView.center=backCent;
            towBackView.transform = CGAffineTransformIdentity;
            backgroundImgView.center = backCent;
            backgroundImgView.transform = CGAffineTransformIdentity;
        }];
        
    }];
    
    UIViewController * main = [AppDelegate App].tabBarController;
    [main.view addSubview:self];
    self.myPage=1;
    self.myCatcontent=nil;
    _isDelegate = YES;
    [HttpRequest eplistRequest:[AppDelegate App].personModel.tokenid contengGuid:contEntGuid lang:@"" page:1 rows:90 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    _favContEntGuid = contEntGuid;
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",contEntGuid] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void) dismiss{
    if (backButton.userInteractionEnabled == NO) {
        return;
    }

    [UIView animateWithDuration:0.6
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformScale(towBackView.transform,0,0);
                         
                         [towBackView setHidden:YES];
                         
                         [towBackView setTransform:transform];
                         
                         [backgroundImgView setTransform:transform];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:towBackView cache:YES];
                         towBackView.center=[AppDelegate App].selctImgCent;
                         
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:backgroundImgView cache:YES];
                         backgroundImgView.center=[AppDelegate App].selctImgCent;
                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];
                         if (_showFrom != showFromFavourite) {
                             UIViewController * main = [AppDelegate App].tabBarController;
                             UIView * view3 = [main.view.subviews lastObject];
                             UIView * view4 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
                             
                             if ([view3 isKindOfClass:[CollectView class]]) {
                                 CollectView * colect = (CollectView *)view3;
                                 //                             colect.gat = nil;
                                 colect.tabelView.userInteractionEnabled = YES;
                             }
                             if ([view4 isKindOfClass:[CollectView class]]) {
                                 CollectView * colect = (CollectView *)view4;
                                 //                             colect.gat = nil;
                                 colect.tabelView.userInteractionEnabled = YES;
                             }

                         }
                         
                         
                         towBackView.transform = CGAffineTransformIdentity;
                         backgroundImgView.transform = CGAffineTransformIdentity;
                         
                     }];
    [_myRequest cancel];
    _myRequest = nil;
    [_addFavouriteRequest cancel];
    _addFavouriteRequest = nil;
    [_delFavouriteRequest cancel];
    _delFavouriteRequest = nil;
    
}

-(void) GetErr:(ASIHTTPRequest *)request{
    backButton.userInteractionEnabled = YES;
    if (request.tag == USERPREFERRNCE_GET_TYPE)
    {
        if (_isPlayEndBack == YES) {
            [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:productID startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            return;
        }
    }
    
    _isGetResult = YES;
    _isDelegate = NO;
    
    
    
    
    _tabelView.userInteractionEnabled=YES;
    playeButton.userInteractionEnabled = YES;
    imgView.userInteractionEnabled = YES;
    _favButton.userInteractionEnabled = YES;
    [activit stopAnimating];
    if (request.error.code == 4) {
        return;
    }
    [Commonality showErrorMsg:towBackView type:0 msg:@"网络连接异常，请重试"];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    _isDelegate = NO;
    [activit stopAnimating];
    playeButton.userInteractionEnabled = YES;
    imgView.userInteractionEnabled = YES;
    NSData *responseData = [request responseData];
    NSLog(@"%@----%d",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding],request.tag);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        [Commonality showErrorMsg:towBackView type:0 msg:@"网络连接异常，请重试"];
        _tabelView.userInteractionEnabled=YES;
        backButton.userInteractionEnabled = YES;
    }else{
        if (request.tag==EPISODELIST_TYPE) {
            _isGetResult = YES;
            _myEpisode = nil;
            _myEpisode=[[ContentEpisodeItemListModel alloc]initWithDictionary:dictionary modelList:self.tableArray page:1];
            
            if (_myEpisode.result==0) {
                if (selectBut==nil) {
                    if (1){//self.myCatcontent==nil) {
                        
                        NSString*str=_myEpisode.contentImg;//[epise.contentImg stringByReplacingOccurrencesOfString:@".jpg" withString:@"-s.jpg"];
                        [imgView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"videoBackground.png"]];
                        
                        if (_myEpisode.isCollect1==1) {
                            [_favButton setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
                        }else{
                            [_favButton setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
                        }
                        
                        _hihel=YES;
                        titleLabel.text=_myEpisode.contentTitle1;
                        playCountLabel.text=[NSString stringWithFormat:@"%i",_myEpisode.playCount1];
                        favCountLabel.text=[NSString stringWithFormat:@"%i",_myEpisode.favoriteCount1];
                        
                        _decLabel.text=_myEpisode.contentDescription;
                        CGSize size = [_decLabel.text sizeWithFont:_decLabel.font constrainedToSize:CGSizeMake(_decLabel.frame.size.width, MAXFLOAT)];
                        _decLabel.frame=CGRectMake(_decLabel.frame.origin.x, _decLabel.frame.origin.y, size.width, size.height);
                        _decLabel.layer.borderColor=[UIColor clearColor].CGColor;
                        _decLabel.layer.borderWidth=0;
                    }
                    
                    
                    
                        //zjj
                    //for (int i=0; i<epise.pages; i++) {
                    for (int i=0; i<_myEpisode.counts/90+1; i++) {
                        //zjj
                        UIButton*but=[UIButton buttonWithType:(UIButtonTypeCustom)];
                        but.frame=CGRectMake(_myScrollView.frame.size.width/4*i, 0, _myScrollView.frame.size.width/4, _myScrollView.frame.size.height);
//                        but.frame=CGRectMake(130*i, 0, 130, _myScrollView.frame.size.height);
                        but.tag=1000+i;
                        [but setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                        but.titleLabel.font=font_5;
                        but.backgroundColor=[UIColor clearColor];
//                        CGFloat top, left, bottom, right; 
                        but.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 20, 0);
                        
                        [but addTarget:self action:@selector(clcikButton:) forControlEvents:UIControlEventTouchUpInside];
                        if (_myEpisode.counts-90*i<90) {
                            [but setTitle:[NSString stringWithFormat:@"%i-%i集",90*i+1,_myEpisode.counts-90*i+90*i] forState:(UIControlStateNormal)];
                        }else{
                            [but setTitle:[NSString stringWithFormat:@"%i-%i集",90*i+1,90+90*i] forState:(UIControlStateNormal)];
                        }
                        
            
                        
//                        [_myScrollView addSubview:but];
//                        if (i==0) {
//                            selectBut=but;
//                        }

                        [_myScrollView addSubview:but];
                        if (i==0) {
                            selectBut=but;
                        }
                    }
                    selectBut.backgroundColor=[UIColor clearColor];
                    [selectBut setTitleColor:color_4 forState:UIControlStateNormal];
                    
                    [selectBut setImage:[UIImage imageNamed:@"Arrow.png"] forState:UIControlStateNormal];
                    selectBut.imageView.hidden = YES;
                    selectBut.imageEdgeInsets = UIEdgeInsetsMake(20, _myScrollView.frame.size.width/4/2, -10, 0);
                   selectBut.imageView.hidden = NO;
                    //zjj
                    //_myScrollView.contentSize=CGSizeMake(100*(epise.pages+2), 0);
                    _myScrollView.contentSize=CGSizeMake(_myScrollView.frame.size.width/4*(_myEpisode.counts/90+1+2), 0);
                    //zjj
                }
                
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                
                NSArray * arr = [user objectForKey:[NSString stringWithFormat:@"children_IsPlay%@",_myEpisode.contentGuid1]];
                if (!arr) {
                    NSMutableArray * addArr = [[NSMutableArray alloc] init];
                    for (int i = 0; i < _myEpisode.episodeCount; i++) {
                        [addArr addObject:[NSString stringWithFormat:@"0"]];
                    }
                    [user setObject:addArr forKey:[NSString stringWithFormat:@"children_IsPlay%@",_myEpisode.contentGuid1]];
                }
                selfContentGuid = _myEpisode.contentGuid1;
        
                [user synchronize];
                [self.tabelView reloadData];
                
            }else{
                
                [Commonality showErrorMsg:towBackView type:_myEpisode.result msg:nil];
                
            }
        }else  if (request.tag==ADDFAVORITE_TYPE){
            _favButton.userInteractionEnabled = YES;
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:nil userInfo:nil];
            }else{
                [Commonality showErrorMsg:towBackView type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
            }
        }else if (request.tag==CANFAVORITE_TYPE){
            _favButton.userInteractionEnabled = YES;
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:nil userInfo:nil];
            }else{
                [Commonality showErrorMsg:towBackView type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
                
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
                
                [_playBut setBackgroundImage:[Commonality imageFromColor:[Commonality colorFromHexRGB:@"ececec"]] forState:UIControlStateNormal];
                
                ContentEpisodeItemListModel*cont;
                if (!_playBut) {
                    cont=[self.tableArray objectAtIndex:0];
                }
                else
                {
                    CHECK_NONERETURN(self.tableArray.count > _playBut.tag - 1);
                    cont=[self.tableArray objectAtIndex:_playBut.tag-1];
                }
                
                cont.oldPlay=YES;

                ChildrenViewController * child = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:1];
                child.showSate = YES;
                
                if (_isPlayEndBack == YES ) {//连播下一集
                    _tabelView.userInteractionEnabled=YES;
                    backButton.userInteractionEnabled = YES;
                    [self performSelector:@selector(playNextVideo:) withObject:str afterDelay:1];//延时播放，防止播放器不显示的bug
                    return;
                }
                if (_isPlayVied == NO) {//选集播放
                    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:_currentSelectedProgramTime];
                    _tabelView.userInteractionEnabled=YES;
                    backButton.userInteractionEnabled = YES;
                    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_Play object:self userInfo:nil];
                    return;
                }
                else//点击播放按钮和海报
                {
                    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:_lastPlayTime];
                    _tabelView.userInteractionEnabled=YES;
                    backButton.userInteractionEnabled = YES;
                    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_Play object:self userInfo:nil];
                    return;
                }
                
            }else{
                if (url.result == 204) {
                    if (!_alert) {
                        _alert = [[UIAlertView alloc] initWithTitle:@"会员权限未开通或已过期" message:@"请先开通会员！" delegate:self cancelButtonTitle:@"稍后开通" otherButtonTitles:@"立即开通", nil];
                    }
                    if (_alert.visible == NO) {
                        [_alert show];
                    }
                    
                    return;
                }
                else
                {
                    _tabelView.userInteractionEnabled=YES;
                    backButton.userInteractionEnabled = YES;
                    [Commonality showErrorMsg:towBackView type:url.result msg:@"网络连接异常，请重试"];
                }
                
            }
        }
        
        else if (request.tag == USERPREFERRNCE_SET_TYPE)
        {
            UserPreferenceModel * pModel = [[UserPreferenceModel alloc] initWithDictionary:dictionary];
            NSArray * arr = [pModel.preferenceValue componentsSeparatedByString:@"."];
//            NSArray * arr1 = [pModel.preferenceKey componentsSeparatedByString:@"."];
            if (pModel.result == 0) {
                if (![Commonality isEmpty:pModel.preferenceValue]) {
                    _lastPlayTime = [[arr lastObject] intValue];
                    currentPlayingIndex = [[arr objectAtIndex:0] intValue];
                }
                else
                {
                    _lastPlayTime = 0;
                    currentPlayingIndex = 1;
                }
            }
            [self performSelector:@selector(reloadPlayTime) withObject:nil afterDelay:1];
            
        }
        else if (request.tag == USERPREFERRNCE_GET_TYPE)
        {
            UserPreferenceModel * pModel = [[UserPreferenceModel alloc] initWithDictionary:dictionary];
            NSArray * arr = [pModel.preferenceValue componentsSeparatedByString:@"."];
            NSArray * arr1 = [pModel.preferenceKey componentsSeparatedByString:@"."];
            if (pModel.result == 0) {
                if (![Commonality isEmpty:pModel.preferenceValue]) {
                    _lastPlayTime = [[arr lastObject] intValue];
                    
                    if (currentPlayingIndex == -1) {
                        currentPlayingIndex = [[arr objectAtIndex:0] intValue];
                    }
                    
                    if ([[arr1 objectAtIndex:0] isEqualToString:@"play"]) {
                        _currentSelectedProgramTime = [[arr lastObject] intValue];
                        if (_isUserPerfernceResult == NO) {
                            [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:productID startTime:@"" endTime:@"" lang:lang delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//                            [self performSelector:@selector(reloadPlayTime) withObject:nil afterDelay:1];
                        }
                    }
                    else
                    {
                        [self reloadPlayTime];
                    }
                    
                }
                else//preferenceValue为空
                {
                    if (currentPlayingIndex == 1) {
                        _currentSelectedProgramTime = _lastPlayTime;
                    }
                    else
                    {
                        _lastPlayTime = 0;
                    }
                    
                    if (currentPlayingIndex == -1) {
                        currentPlayingIndex = 1;
                    }
                    if ([[arr1 objectAtIndex:0] isEqualToString:@"play"]) {
                        _currentSelectedProgramTime = _lastPlayTime;
                        [HttpRequest PlayUrlRequest:[AppDelegate App].personModel.tokenid pid:@"" protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:productID startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                    }
                    else
                    {
                        lastPlayTimeLab.text = nil;
                    }
                    
                    
                    
                }
            }
            else
            {
                if (pModel.result == 400) {
                    if ([AppDelegate App].isLogin == NO) {
                        return;
                    }
                }
                [Commonality showErrorMsg:self type:pModel.result msg:LINGKERROR];
            }

            
            
        }
        
            
            
            
    }
}

-(void)reloadPlayTime
{
    int hour = _lastPlayTime/3600;
    int sec = _lastPlayTime%3600;
    int min = sec/60;
    int second = sec%60;
    
    if (currentPlayingIndex == 0) {
        currentPlayingIndex = 1;
    }
    
    if (hour == 0) {
        lastPlayTimeLab.text = [NSString stringWithFormat:@"上次观看到第%d集%d分%d秒",currentPlayingIndex,min,second];
    }
    else
    {
        lastPlayTimeLab.text = [NSString stringWithFormat:@"上次观看到第%d集%d时%d分%d秒",currentPlayingIndex,hour,min,second];
    }
}

-(void)playNextVideo:(NSString *)url
{
    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:url withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:0];
    _isPlayEndBack = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_Play object:self userInfo:nil];
}

-(void)releaseTableView
{
    _tabelView.userInteractionEnabled=YES;
    backButton.userInteractionEnabled = YES;
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        [self performSelector:@selector(showMyProgramPackageView) withObject:nil afterDelay:1];
        [self performSelector:@selector(releaseTableView) withObject:nil afterDelay:1.5];
    }
    else
    {
        _tabelView.userInteractionEnabled=YES;
        backButton.userInteractionEnabled = YES;
    }
}

-(void)showMyProgramPackageView
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.productId = productID;
    if (_showFrom != showFromFavourite) {
        pro.isShowFromMain = YES;
    }
    else
    {
        pro.isShowFromMain = NO;
    }
    [pro show];
}

-(void)clcikButton:(UIButton*)sender{
    self.myPage=sender.tag-1000+1;
    selectBut.backgroundColor=[UIColor clearColor];
    [selectBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectBut.imageView.hidden = YES;
    selectBut.alpha = alpha_4;
    selectBut=sender;
    selectBut.backgroundColor=[UIColor clearColor];
    [selectBut setTitleColor:color_4 forState:UIControlStateNormal];
    selectBut.alpha = 1;
    [selectBut setImage:[UIImage imageNamed:@"Arrow.png"] forState:UIControlStateNormal];
    selectBut.imageView.hidden = YES;
    selectBut.imageEdgeInsets = UIEdgeInsetsMake(20, _myScrollView.frame.size.width/4/2, -10, 0);
    selectBut.imageView.hidden = NO;
    [_tabelView reloadData];
    
}

-(void)clickNextBtn
{
    UIButton * btn = (UIButton*)[_tabelView viewWithTag:_playBut.tag + 1];
    if (btn) {
        _isPlayEndBack = YES;
        [self clickPlay:btn];
    }
}

-(void)iPadPlayerCallBack:(iPadPlayerCallBackEventType)callBackEventType withParameter:(NSMutableDictionary *)callBackInfo
{
    
    NSLog(@"callBackInfo is %@",callBackInfo);
    NSLog(@"callBackEventType is %d",callBackEventType);
    
    if (_isMain == YES) {
        int time = [[callBackInfo objectForKey:@"time"] intValue];
        [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",_favContEntGuid] preferenceValue:[NSString stringWithFormat:@"1.%d",time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        return;
    }
    
    
    if ([AppDelegate App].tabBarController.viewCtlNum == 0) {
       MainViewController * main = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        main.isPlayBack = YES;
    }
    
    if (callBackEventType == iPadPlayerWillPlaybackEnded) {
        if (_playBut.tag%90 == 0) {
          UIButton * btn1 = (UIButton *)[_myScrollView viewWithTag:1000 + _playBut.tag/90];
            if (btn1) {
                [self clcikButton:btn1];
                NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
                [_tabelView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
        }
        UIButton * btn = (UIButton*)[_tabelView viewWithTag:_playBut.tag + 1];
        NSLog(@"_playBut.tag + 1 is %d",_playBut.tag + 1);
        NSLog(@"btn is %@",btn);
        if (btn) {
            _isPlayEndBack = YES;
            [self clickPlay:btn];
        }
        else
        {
            if (self.tableArray.count >= _playBut.tag + 1) {
                UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn2.tag = _playBut.tag + 1;
                _isPlayEndBack = YES;
                [self clickPlay:btn2];
            }
        }
    }
    else if (callBackEventType == iPadPlayerUserExited)
    {
        _isPlayEndBack = NO;
        int time = [[callBackInfo objectForKey:@"time"] intValue];
        if (self.myCatcontent) {
            
            [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",self.myCatcontent.contentGuid] preferenceValue:[NSString stringWithFormat:@"%d.%d",currentPlayingIndex,time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            
            _isUserPerfernceResult = YES;
            [self performSelector:@selector(setMyPreferenceValue:) withObject:callBackInfo afterDelay:0.5];
        }
        else
        {
            //from favourite
            [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"episode.%@",_favContEntGuid] preferenceValue:[NSString stringWithFormat:@"%d.%d",currentPlayingIndex,time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            
            _isUserPerfernceResult = YES;
            [self performSelector:@selector(setMyPreferenceValue:) withObject:callBackInfo afterDelay:0.5];
        }
        
    }
}

-(void)setMyPreferenceValue:(NSDictionary*)callBackInfo
{
    int time = [[callBackInfo objectForKey:@"time"] intValue];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:[NSString stringWithFormat:@"%d.%d",currentPlayingIndex,time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];//当前集
}

@end
