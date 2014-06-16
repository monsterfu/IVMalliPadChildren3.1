//
//  productInfoView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-12.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@protocol dismissProgramPackageDelegate <NSObject>
-(void)dismissProgramPackage;
@end

@interface productInfoView : UIView<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    CGRect rect;
    UILabel * produtTitle;
    UILabel * procutPoint;
    
}
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) UIView * myView;
@property (nonatomic, strong) NSString * productId;
@property (nonatomic, strong) NSMutableArray * proInfoArr;
@property (nonatomic, assign) id<dismissProgramPackageDelegate>delegate;
-(void)show;
-(void)dismiss;
@end
