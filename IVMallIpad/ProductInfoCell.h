//
//  ProductInfoCell.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-12.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLab;
@property (strong, nonatomic) IBOutlet UILabel *playTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *favouriteCountLab;
@property (strong, nonatomic) IBOutlet UIButton *favouriteBtn;
- (IBAction)favourite:(UIButton *)sender;

@end
