//
//  ChildrenProductView.m
//  IVMall HD
//
//  Created by  周传森 on 14-4-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ChildrenProductView.h"
#import "AppDelegate.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "Macro.h"
#import "MainViewController.h"
#import "CustomTabBarCtl.h"

@implementation ChildrenProductView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self ;
//}

-(void)callbackPlay:(NSString *)url name:(NSString *)nsme
{

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        self.exclusiveTouch = YES;
    }
    return self ;
}

-(void)tapImage:(UITapGestureRecognizer *)tap
{
    MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
    if (main.overTap == NO) {
        main.overTap = YES;
        [AppDelegate App].selctImgCent=CGPointMake(tap.view.center.x+3, tap.view.center.y+120);
        if ([_contentType isEqualToString:@"vod"]) {
//            if (gatherView) {
//                gatherView = nil;
//            }
//            gatherView = [[GatherView alloc] initMy:nil];
//            gatherView.delegate = self;
//            [gatherView showFormFav:_contentGuid];
            if (main.gather) {
                main.gather = nil;
            }
            main.gather = [[GatherView alloc] initMy:nil];
            main.gather.delegate = self;
            [main.gather showFormMain:_contentGuid];
        }
        [self performSelector:@selector(clearOverTap) withObject:nil afterDelay:0.8];
    }
    
}

-(void)clearOverTap
{
    MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
    main.overTap = NO;
}

-(void)changeFavouriteState
{
    if (_isCollect == NO) {
        [_favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec2.png"] forState:(UIControlStateNormal)];
        self.isCollect = YES;
        return;
    }
    else
    {
        [_favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec.png"] forState:(UIControlStateNormal)];
        self.isCollect = NO;
        return;
    }
}

- (IBAction)clickFavouriteBtn:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    if (![AppDelegate App].isLogin) {
        MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        [main clickUserButton:nil];
        sender.userInteractionEnabled = YES;
        return;
    }
    if (_isCollect == NO) {
        [HttpRequest addFavorRequest:[AppDelegate App].personModel.tokenid contentGiud:_contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        return;
    }
    else
    {
        [HttpRequest caelFavorWithConteng:[AppDelegate App].personModel.tokenid contentGiud:_contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        return;
    }
}

-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
}


-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
    }else{
        if (request.tag==ADDFAVORITE_TYPE){
            _favouriteBtn.userInteractionEnabled = YES;
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                [_favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec2.png"] forState:(UIControlStateNormal)];
                self.isCollect = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:self userInfo:nil];
            }else{
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
            }
        }else if (request.tag==CANFAVORITE_TYPE){
            _favouriteBtn.userInteractionEnabled = YES;
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                [_favouriteBtn setBackgroundImage:[UIImage imageNamed:@"onLIveCollec.png"] forState:(UIControlStateNormal)];
                self.isCollect = NO;
                [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:self userInfo:nil];
            }else{
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
            }
        }

    }
}

@end
