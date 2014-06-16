//
//  CustomTabBarCtl.h
//  CustomTabBarController
//
//  Created by 周传森 on 14-2-28.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarCtl : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
//    UIView * _customContentView;
    UIView * _tabBar;
    UIScrollView * _tabBarScroll;
    UIView * _animationView;
    NSMutableArray * _titleArr;
    NSMutableDictionary * _imgDic;
    UILabel * _titleLab;
    UILabel* _titleLabel;
    UIAlertView* _noWifiAlertView;
}
- (id) initWithCtl:(NSMutableArray *)viewCtlArr andTitleStr:(NSMutableArray *)titleArr andImgDic:(NSMutableDictionary *)imgDic;
@property(nonatomic,strong)NSMutableArray * viewControllers;
@property(nonatomic,assign)int viewCtlNum;
@property(nonatomic,strong)UIView * customContentView;
@property(nonatomic,assign)BOOL isTakingPhoto;
-(void)chooseView;
-(void)takePhoto;
-(void)reloadViewCtlsWithTitleArr:(NSMutableArray *)titleArr andViewCtlArr:(NSMutableArray *)viewCtlArr;
@end
