//
//  RechargeSucessView.m
//  IVMallHD
//
//  Created by Monster on 14-5-29.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "RechargeSucessView.h"
#import "AppDelegate.h"
@implementation RechargeSucessView

- (id)initWithFrame:(CGRect)frame isPop:(BOOL)isPop isMain:(BOOL)isMain
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _myView = [[UIView alloc] init];
        _myView.frame = [AppDelegate App].window.bounds;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        [self addSubview:_myView];
        
        // Initialization code
        bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bg.image = [UIImage imageNamed:@"Success_bg1.png"];
        [self addSubview:bg];
        
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(30, 30, 45, 45)];
        [backButton setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [backButton addTarget:self  action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        backButton.backgroundColor=[UIColor clearColor];
        [self addSubview:backButton];
        
        sucussLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 130, 552, 50)];
        sucussLabel.text = @"充值成功!";
        sucussLabel.textAlignment = NSTextAlignmentLeft;
        sucussLabel.textColor = [UIColor whiteColor];
        sucussLabel.font = [UIFont boldSystemFontOfSize:40];
        sucussLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sucussLabel];
        
        
        balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 180, 200, 30)];
        balanceLabel.textColor = [UIColor whiteColor];
        balanceLabel.textAlignment = NSTextAlignmentLeft;
        balanceLabel.font = [UIFont boldSystemFontOfSize:15];
        balanceLabel.text = @"wat5etyet";
        balanceLabel.alpha = 0.8;
        balanceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:balanceLabel];
        
        _isPop = isPop;
        _isMain = isMain;
    }
    return self;
}
- (void)setButtonBlock:(ButtonBlock)block{
    _buttonBlock = block;
}
-(void)dismiss:(UIButton*)sender
{
    if (_buttonBlock)
        _buttonBlock(sender);
    
    UIViewController* main;
    if (_isMain) {
        main = [AppDelegate App].tabBarController;
    }else{
        main = [AppDelegate App].personView;
    }
    [UIView animateWithDuration:1.0
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformScale(self.transform,0,0);
                         [self setTransform:transform];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self cache:YES];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                         if (_isPop) {
                             UIView * view1 = [main.view.subviews lastObject];
                             UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
                             view1.hidden = NO;
                             view2.hidden = NO;
                         }
                         self.transform = CGAffineTransformIdentity;
                         
                     }];
    
}
-(void)setBalanceText:(NSString *)balance
{
    balanceLabel.text = balance;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)show
{
    if (_isPop == YES) {
        UIWindow*wind=[UIApplication sharedApplication].keyWindow;
        UIViewController * main;
        if (_isMain) {
            main = [AppDelegate App].tabBarController;
        }else{
            main = [AppDelegate App].personView;
        }
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.center = wind.center;
                         }];
        
        
        UIView * view1 = [main.view.subviews lastObject];
        UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
        self.center=CGPointMake(self.frame.origin.x+self.frame.size.width/2, self.frame.origin.y+self.frame.size.height);
        if (view1 != [AppDelegate App].tabBarController.customContentView) {
            view1.hidden = YES;
            view2.hidden = YES;
        }
        
        _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _myView.alpha = 0.5;
        [main.view addSubview:_myView];
        self.frame = CGRectMake(main.view.frame.size.width/2 - 276, main.view.frame.size.height/2 - 209, 552, 354);
        bg.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [main.view addSubview:self];
        
    }
    else
    {
        UIWindow*wind=[UIApplication sharedApplication].keyWindow;
        UIViewController * main = [AppDelegate App].personView;
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.center = wind.center;
                         }];
        
        _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _myView.alpha = 0.5;
        [main.view addSubview:_myView];
        //    624 552
        self.frame = CGRectMake(main.view.frame.size.width/2 - 276, main.view.frame.size.height/2 - 209, 552, 354);
        bg.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [main.view addSubview:self];
    }
}
@end
