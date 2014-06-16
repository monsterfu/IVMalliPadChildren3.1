//
//  Favourite_EdittingCell.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Favourite_EdittingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *delBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

- (IBAction)del:(id)sender;

@end
