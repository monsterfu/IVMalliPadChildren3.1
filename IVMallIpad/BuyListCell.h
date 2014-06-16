//
//  BuyListCell.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-6.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *balanceLab;
@property (strong, nonatomic) IBOutlet UILabel *buyTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *dueTimeTab;
@property (strong, nonatomic) IBOutlet UIView *lineView;

@end
