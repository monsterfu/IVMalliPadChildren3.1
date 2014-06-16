//
//  ProgramPackage.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-11.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramVipCell.h"
#import "ProgramCell.h"
#import "ASIHTTPRequest.h"
#import "productInfoView.h"
#import "BuyVipView.h"
#import "PersonnalCenter.h"
//@protocol ProgramPackageReloadUserViewDelegate;
@interface ProgramPackage : UIView<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,showProgramPackageDelegate,dismissProgramPackageDelegate>
{
    CGRect rect;
    productInfoView * proInfo;
    BuyVipView * buyVip;
    UIImageView * backgroundImgView;
    
}
@property(nonatomic,strong)UIViewController * viewCtl;
@property (nonatomic, strong) NSMutableArray * vipArr;
@property (nonatomic, strong) NSMutableArray * programArr;
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) UIView * myView;
@property (nonatomic, strong) NSString * productId;
@property (nonatomic, assign) BOOL isVipList;
@property (nonatomic, assign) BOOL isShowFromMain;
//@property (nonatomic, assign) id<ProgramPackageReloadUserViewDelegate> reloadUserViewDelegate;
-(id)initWithVipArr:(NSMutableArray *)VipArr andProgramDic:(NSMutableArray *)programArr;
-(void)show;
-(void)dismiss;
-(void)clickBuyVipBtn:(int)tag;
-(void)clickProgramBtn:(int)tag;
@end

//@protocol ProgramPackageReloadUserViewDelegate <NSObject>
//-(void)reloadUserView;
//@end

