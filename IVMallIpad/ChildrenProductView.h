//
//  ChildrenProductView.h
//  IVMall HD
//
//  Created by  周传森 on 14-4-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GatherView.h"

@interface ChildrenProductView : UIView<GatherViewDelegate>
{
//    GatherView * gatherView;
}
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIButton *favouriteBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *playCountLab;
@property (strong, nonatomic) IBOutlet UILabel *favouriteCountLab;
@property (assign, nonatomic) int nub;
- (IBAction)clickFavouriteBtn:(UIButton *)sender;
@property (strong, nonatomic) NSString * contentGuid;
@property (assign, nonatomic) BOOL isCollect;
@property (strong, nonatomic) NSString * contentType;

@end
