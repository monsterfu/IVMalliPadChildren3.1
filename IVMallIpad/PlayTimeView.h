//
//  PlayTimeView.h
//  IVMallHD
//
//  Created by  周传森 on 14-4-18.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface PlayTimeView : UIView
{
    CGRect rect;
    CGRect tmpRect;
}
- (IBAction)back:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *NameLab;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *lastDay;
@property (strong, nonatomic) IBOutlet UILabel *lastWeak;
@property (strong, nonatomic) IBOutlet UILabel *lastMonth;
@property (strong, nonatomic) IBOutlet UILabel *lastDayTitle;
@property (strong, nonatomic) IBOutlet UILabel *lastWeakTitle;
@property (strong, nonatomic) IBOutlet UILabel *lastMonthTitle;
@property(nonatomic,assign)BOOL hihel;
-(void)show;
-(void)dismiss;
-(void)GetErr:(ASIHTTPRequest *)request;
-(void)GetResult:(ASIHTTPRequest *)request;

@end
