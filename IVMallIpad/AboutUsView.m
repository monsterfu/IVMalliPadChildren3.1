//
//  AboutUsView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-10.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "AboutUsView.h"
#import "AppDelegate.h"
#import "UIButton+Bootstrap.h"
@implementation AboutUsView
{
    NSURL * trackViewUrl;
}

-(id) initMyWithFrame:(CGRect )newRect
{
   
   if (self=[super init]) {
        // Initialization code
       _isShowing = NO;
        rect=[[UIScreen mainScreen]bounds];
       UIViewController * main = [AppDelegate App].tabBarController;
       _myView = [[UIView alloc] init];
       _myView.frame = main.view.frame;
       _myView.backgroundColor=[UIColor blackColor];
       _myView.alpha=0;
       _myView.userInteractionEnabled=YES;
       
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissALLView)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
//        self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
        self.frame = newRect;
        self.backgroundColor=color_22;
        tmpRect = self.frame;
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 0)];
        heatView.backgroundColor=[Commonality colorFromHexRGB:HEADVIEW_BACKGROUND_COLOR];
       
       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 50, 92, 100, 100)];
       imageView.image = [UIImage imageNamed:@"about.png"];
       imageView.backgroundColor = [UIColor clearColor];
       [self addSubview:imageView];
       
       UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 12, tmpRect.size.width, 30)];
       lab.backgroundColor = [UIColor clearColor];
       lab.text = @"爱V猫幼学堂";
       lab.textColor = color_17;
       lab.font = font_8;
       lab.textAlignment = NSTextAlignmentCenter;
       [self addSubview:lab];
       
       _VersonLab =  [[UILabel alloc] initWithFrame:CGRectMake(0, lab.frame.origin.y + lab.frame.size.height , tmpRect.size.width, 30)];
       _VersonLab.backgroundColor = [UIColor clearColor];
       _VersonLab.textColor = [UIColor blackColor];
       _VersonLab.font = font_5;
       _VersonLab.textAlignment = NSTextAlignmentCenter;
       _VersonLab.alpha = alpha_3;
       [self addSubview:_VersonLab];
       
       UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
       btn.frame = CGRectMake(newRect.size.width/2 - 160, 330, 320, 51);
       btn.backgroundColor=color_4;
       [btn setTitle:@"400-990-4909" forState:UIControlStateNormal];
       [btn addTarget:self action:@selector(makeTelePhone) forControlEvents:UIControlEventTouchUpInside];
//       btn.layer.cornerRadius = 4.0;
//       btn.layer.masksToBounds = YES;
       [btn childrenBtnStyleForBtn:btn];
       UIView * btnVIew = [Commonality makeButtonShadowViewWhitbtn:btn];
       [self addSubview:btnVIew];
       
       UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
       btn1.frame = CGRectMake(newRect.size.width/2 - 160, 395, 320, 51);
       btn1.backgroundColor=color_20;
       [btn1 setTitle:@"版本检测" forState:UIControlStateNormal];
       btn1.tag = 503;
       btn1.alpha = 1;
       [btn1 childrenBtnStyleForBtn:btn1];
       UIView * btnView1 = [Commonality makeButtonShadowViewWhitbtn:btn1];
     
       
       [btn1 addTarget:self action:@selector(checkVerson:) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:btnView1];
       
//       UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, tmpRect.size.height- 80, tmpRect.size.width, 30)];
       UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, newRect.size.height - 85, newRect.size.width, 30)];
       lab1.backgroundColor = [UIColor clearColor];
       lab1.textColor = [UIColor blackColor];
       lab1.font = font_3;
       lab1.textAlignment = NSTextAlignmentCenter;
       lab1.alpha = alpha_3;
       lab1.text = @"www.ivmall.com";
       [self addSubview:lab1];
       UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, newRect.size.height - 63, newRect.size.width, 30)];
       lab2.backgroundColor = [UIColor clearColor];
       lab2.textColor = [UIColor blackColor];
       lab2.font = font_3;
       lab2.textAlignment = NSTextAlignmentCenter;
       lab2.alpha = alpha_3;
       lab2.text = @"Copyright © 2014 iVmall All Rights Reserved";
       [self addSubview:lab2];
    }
    return self;
}

-(void)checkVerson:(UIButton * )btn;
{
    btn.enabled = NO;
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
//    [loading startAnimating];
//    [sender setEnabled:NO];
    ASIHTTPRequest* asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:APP_URL]];
    asiRequest.tag=CHECKVERSION_TYPE;
    [asiRequest setRequestMethod:@"GET"];
//    [asiRequest setUseSessionPersistence:YES];
//    [asiRequest setUseCookiePersistence:YES];
    [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [asiRequest setDelegate:self];
    [asiRequest setDidFinishSelector:@selector(GetResult:)];
    [asiRequest setDidFailSelector:@selector(GetErr:)];
    [asiRequest startAsynchronous];
}

-(void)makeTelePhone
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"4009904909"]]]; //拨号
}

-(void)dismissALLView
{
    [Commonality dismissAllView];
}

-(void)show{
    _hihel=YES;
    _VersonLab.text=[NSString stringWithFormat:@"版本:V%@",IVMALL_VERSION];

//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                         _myView.alpha = 0;
//                     }];
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
}
-(void)dismiss{
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0;
                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                     }];
    
}

-(void) GetErr:(ASIHTTPRequest *)request
{

    UIButton * btn = (UIButton *)[self viewWithTag:503];
    [btn setEnabled:YES];
//    [loading stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:LINGKERROR delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 10002;
    [alert show];
}

-(void) GetResult:(ASIHTTPRequest * )request
{
    UIButton * btn = (UIButton *)[self viewWithTag:503];
    [btn setEnabled:YES];
//    [loading stopAnimating];
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if(dictionary!=nil){
        if (request.tag==CHECKVERSION_TYPE) {
            NSString* currentVersion = IVMALL_VERSION;
            NSArray *infoArray = [dictionary objectForKey:@"results"];
            if ([infoArray count]) {
                NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                NSString *lastVersion = [releaseInfo objectForKey:@"version"];
                
                int version_x = 0,version_y = 0, version_z = 0;
                int current_x = 0,current_y = 0, current_z = 0;
                sscanf([lastVersion UTF8String],"%d.%d.%d",&version_x,&version_y,&version_z);
                sscanf([currentVersion UTF8String],"%d.%d.%d",&current_x,&current_y,&current_z);
                
                if((version_x>current_x) || (version_x==current_x && version_y>current_y) || (version_x==current_x && version_y==current_y && version_z>current_z))
                {
                    trackViewUrl = [NSURL URLWithString:[releaseInfo objectForKey:@"trackViewUrl"]];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                    alert.tag = 10000;
                    [alert show];
                    return;
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    alert.tag = 10001;
                    [alert show];
                    return;
                }
                
            }
        }
    }

}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            if ([[UIApplication sharedApplication]canOpenURL:trackViewUrl]) {
                [[UIApplication sharedApplication]openURL:trackViewUrl];
            }
            
        }
    }
}
@end
