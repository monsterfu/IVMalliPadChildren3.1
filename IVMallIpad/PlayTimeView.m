//
//  PlayTimeView.m
//  IVMallHD
//
//  Created by  周传森 on 14-4-18.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "PlayTimeView.h"
#import "AppDelegate.h"
#import "Commonality.h"

@implementation PlayTimeView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        rect=[[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//        [Commonality setImgViewStyle:self];
    }
    return self ;
}

-(void)show
{
    _lastDayTitle.textColor = color_2;
    _lastWeakTitle.textColor = color_2;
    _lastMonthTitle.textColor = color_2;
    _NameLab.textColor = color_2;
    _backView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = color_21;
//    _NameLab.text = [NSString stringWithFormat:@"%@，您好",[AppDelegate App].personModel.mobile];
    NSString * str1 = [[AppDelegate App].personModel.mobile substringToIndex:4];
    NSString * str2 = [[AppDelegate App].personModel.mobile substringFromIndex:7];
    _NameLab.text = [NSString stringWithFormat:@"%@***%@，您好!",str1,str2];
    _hihel = YES;
//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                     }];
//    [main.view addSubview:self];
    [HttpRequest playTimeRequestToken:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];
                     }];
}

- (IBAction)back:(UIButton *)sender {
    return;
    [self dismiss];
}

-(void)GetErr:(ASIHTTPRequest *)request
{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
}
-(void)GetResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
    }else{
        if (![[dictionary objectForKey:@"errorCode"] intValue] == 0) {
            [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"] intValue] msg:@"网络连接异常！"];
            return;
        }
        int playTime = [[[[dictionary objectForKey:@"data"] objectForKey:@"playTime"] objectForKey:@"total"] intValue];
        int hour = playTime/3600;
        int sec = playTime%3600;
        int min = sec/60;
        _totalTimeLab.text = [NSString stringWithFormat:@"您总共观看了%d小时%d分",hour,min];
        
        int lastPlayTime = [[[[dictionary objectForKey:@"data"] objectForKey:@"playTime"] objectForKey:@"day"] intValue];
        int hour1 = lastPlayTime/3600;
        int sec1 = lastPlayTime%3600;
        int min1 = sec1/60;
        _lastDay.text = [NSString stringWithFormat:@"您总共观看了%d小时%d分",hour1,min1];
        
        int lastWeekPlayTime = [[[[dictionary objectForKey:@"data"] objectForKey:@"playTime"] objectForKey:@"week"] intValue];
        int hour2 = lastWeekPlayTime/3600;
        int sec2 = lastWeekPlayTime%3600;
        int min2 = sec2/60;
        _lastWeak.text = [NSString stringWithFormat:@"您总共观看了%d小时%d分",hour2,min2];
        
        int lastMonthPlayTime = [[[[dictionary objectForKey:@"data"] objectForKey:@"playTime"] objectForKey:@"month"] intValue];
        int hour3 = lastMonthPlayTime/3600;
        int sec3 = lastMonthPlayTime%3600;
        int min3 = sec3/60;
        _lastMonth.text = [NSString stringWithFormat:@"您总共观看了%d小时%d分",hour3,min3];
    }
}
@end
