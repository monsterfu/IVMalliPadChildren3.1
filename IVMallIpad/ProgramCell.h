//
//  ProgramCell.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-11.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *pointLab;
@property (strong, nonatomic) IBOutlet UILabel *programCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sourceLab;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLab;
@property (strong, nonatomic) IBOutlet UIButton *buyBtn;
- (IBAction)buy:(UIButton *)sender;

@end
