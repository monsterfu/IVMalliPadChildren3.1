//
//  BackView.m
//  IVMall (Ipad)
//
//  Created by sean on 14-3-11.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "BackView.h"

#define LINE_MAXNUM  (5)

@implementation BackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

            
-(void)show:(int)count{
    for(UIView *view in [self subviews]){
        [view removeFromSuperview];
    }
    int iscon=0;
    int iscont2=0;
    if (count<LINE_MAXNUM) {
        iscon=1;
    }else{
        iscon=2;
    }
    
    for (int i=0; i<iscon; i++) {
        iscont2 = (count-LINE_MAXNUM*i > LINE_MAXNUM)?(LINE_MAXNUM):(count-LINE_MAXNUM*i);
        
        for (int j=0; j<iscont2; j++) {
            
            UIImageView*imgVIew=[[UIImageView alloc]initWithFrame:CGRectMake(58*(j+1)+(self.frame.size.width-182)/6*j, self.frame.size.height/2*i, (self.frame.size.width-182)/6,self.frame.size.height/2-60)];
            imgVIew.userInteractionEnabled=YES;
            imgVIew.image=[UIImage imageNamed:@"videoBackground.png"];
            [self addSubview:imgVIew];
        }
    }

}



@end
