//
//  ProgramVipCell.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-11.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ProgramVipCell.h"
#import "AppDelegate.h"
#import "ProgramPackage.h"

@implementation ProgramVipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buy:(id)sender {
    UIButton * btn = (UIButton *)sender;
    
//    if (![AppDelegate App].isLogin) {
//        if ([AppDelegate App].userView == nil) {
//            [AppDelegate App].userView = [[UserView alloc] init];
//        }
//        [[AppDelegate App].userView show];
//        return;
//    }
    
    ProgramPackage * pro = nil;
    if ([AppDelegate App].isIOS7) {
        pro = (ProgramPackage *) self.viewForBaselineLayout.superview.superview.superview;
        
    }else{
        pro = (ProgramPackage *) self.viewForBaselineLayout.superview.superview;
    }
    [pro clickBuyVipBtn:btn.tag];
}
@end
