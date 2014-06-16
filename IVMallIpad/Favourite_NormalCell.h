//
//  Favourite_NormalCell.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Favourite_NormalCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *colletTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

@end
