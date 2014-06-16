//
//  AboutUsView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-10.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "Commonality.h"

@interface AboutUsView : UIView<UIAlertViewDelegate>
{
    CGRect rect;
    CGRect tmpRect;
}
@property(nonatomic,strong)UIView*myView;
@property(nonatomic,assign)BOOL hihel;
@property(nonatomic,strong) UILabel * VersonLab;
@property(nonatomic,assign)BOOL isShowing;
-(id) initMyWithFrame:(CGRect )newRect;
-(void) show;

-(void) dismiss;
@end
