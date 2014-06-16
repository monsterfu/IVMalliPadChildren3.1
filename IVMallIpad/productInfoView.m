//
//  productInfoView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-12.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "productInfoView.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "ProductInfoCell.h"
#import "UIButton+Bootstrap.h"
#import "AppDelegate.h"
#import "ProductInfoModel.h"
#import "UIImageView+WebCache.h"
#import "IVMallPlayer.h"
#import "BuyAddModel.h"

@implementation productInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        rect=[[UIScreen mainScreen]bounds];
        _proInfoArr = [[NSMutableArray alloc] init];
        self.frame=CGRectMake(-128 + 200, 128 + 25, rect.size.height - 400, rect.size.width- 50);
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(30, 30, 30, 30);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"返回2.png"] forState:(UIControlStateNormal)];
        [btn2 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2- 50, 10, 150, 30)];
        lab.text = @"节目套餐详情";
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.backgroundColor = [UIColor clearColor];
        [self addSubview:lab];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rect.size.height - 460
        btn.frame = CGRectMake(self.frame.size.width - 60, 30, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"X.png"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, rect.size.height - 400, rect.size.width- 180) ];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor=[UIColor clearColor];
        _myTableView.separatorStyle=NO;
        [_myTableView registerNib:[UINib nibWithNibName:@"ProductInfoCell" bundle:nil] forCellReuseIdentifier:@"ProductInfo"];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + _myTableView.frame.size.height, rect.size.height - 400, rect.size.width - _myTableView.frame.size.height - 100)];
        bottomView.backgroundColor = [UIColor whiteColor];
        bottomView.layer.cornerRadius = 5;
        
        produtTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 180, 30)];
        produtTitle.textAlignment = NSTextAlignmentRight;
        produtTitle.font = [UIFont systemFontOfSize:15];
        produtTitle.textColor = [Commonality colorFromHexRGB:@"0975cd"];
        produtTitle.backgroundColor = [UIColor clearColor];
       
        [bottomView addSubview:produtTitle];
        
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 15, 60, 30)];
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = [UIFont systemFontOfSize:15];
        lab1.textColor = [UIColor blackColor];
        lab1.alpha = 0.8;
        lab1.backgroundColor = [UIColor clearColor];
        lab1.text = @"总价：";
        [bottomView addSubview:lab1];
        
        procutPoint = [[UILabel alloc] initWithFrame:CGRectMake(260, 15, 160, 30)];
        procutPoint.textAlignment = NSTextAlignmentLeft;
        procutPoint.font = [UIFont systemFontOfSize:22];
        procutPoint.textColor = [Commonality colorFromHexRGB:@"e13a68"];
        procutPoint.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:procutPoint];
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(440, 5, 160, 50);
        [btn1 setTitle:@"立即购买" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(buyProduct) forControlEvents:UIControlEventTouchUpInside];
        [btn1 blueStyle];
        [bottomView addSubview:btn1];
        
        [self addSubview:bottomView];
        
        
        [self addSubview:_myTableView];
        
//        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        tap.numberOfTapsRequired=1;
//        [_myView addGestureRecognizer:tap];

        self.backgroundColor=[UIColor whiteColor];
        [Commonality setImgViewStyle:self];
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)buyProduct
{
    
    //if ([[AppDelegate App].personModel.balance floatValue] > [procutPoint.text floatValue]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary* deviceInfoDic = [[IVMallPlayer sharedIVMallPlayer] IVMallPlayerGetLocalInfo];
        [HttpRequest BuyProduct:[AppDelegate App].personModel.tokenid pid:self.productId delegate:self PassWord:[userDefaults objectForKey:@"password"] deviceDRMId:[deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:[deviceInfoDic objectForKey:@"drmType"] finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    }
//    else
//    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:@"您的余额不足，现在去充值？" delegate:self cancelButtonTitle:@"稍后再充" otherButtonTitles:@"现在就去", nil];
//        alert.tag = 501;
//        [alert show];
//    }
}

-(void)show{
    
    UIViewController * main = [AppDelegate App].tabBarController;

    UIView * view1 = [main.view.subviews lastObject];
    UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
    view1.hidden = YES;
    view2.hidden = YES;
    
    [HttpRequest proInfoRequest:[AppDelegate App].personModel.tokenid contentGuid:self.productId delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    _myView.frame = CGRectMake(main.view.frame.origin.x, main.view.frame.origin.y, main.view.frame.size.height, main.view.frame.size.width);
    _myView.alpha = 0.5;
    [main.view addSubview:_myView];
    self.frame = CGRectMake(main.view.frame.size.height/2 - (rect.size.height - 400)/2, main.view.frame.size.width/2- (rect.size.width- 50)/2, rect.size.height - 400, rect.size.width- 50);
    [main.view addSubview:self];

}

-(void)dismiss
{
    [HttpRequest myCancelAsi];
    UIViewController * main = [AppDelegate App].tabBarController;

    [_myView removeFromSuperview];
    [self removeFromSuperview];
    
    UIView * view1 = [main.view.subviews lastObject];
    UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
    view1.hidden = NO;
    view2.hidden = NO;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _proInfoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * myCell = @"ProductInfo";
    ProductInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[ProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    CHECK_RETURN_CELL(_proInfoArr.count > indexPath.row, cell);
    ProductInfoModel * proInfoModel = [_proInfoArr objectAtIndex:indexPath.row];
    
    cell.titleLab.text = proInfoModel.productTitle;
    cell.descriptionLab.text = proInfoModel.productDescription;
    cell.favouriteCountLab.text = proInfoModel.favoriteCount;
    cell.playTimeLab.text = proInfoModel.playCount;
    [cell.imgeView setImageWithURL:[NSURL URLWithString:proInfoModel.productImg]];
    cell.imgeView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgeView.clipsToBounds = YES;
    cell.favouriteBtn.tag = indexPath.row;
    if ([proInfoModel.isCollect isEqualToString:@"0"]) {
        [cell.favouriteBtn setImage:[UIImage imageNamed:@"Collection3.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.favouriteBtn setImage:[UIImage imageNamed:@"Collection2.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

-(void)showRechargeView
{
    
//    if ([AppDelegate App].rechargeView==nil) {
//        [AppDelegate App].rechargeView=[[RechargeView alloc]initMy];
//    }
//    
//    [Commonality anmou1View:[AppDelegate App].rechargeView delegate:[AppDelegate App].tabBarController];
//    [[AppDelegate App].rechargeView show];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        if (alertView.tag == 501) {
            [self performSelector:@selector(showRechargeView) withObject:nil afterDelay:1];
        }
    }
}

-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
//    NSString*str=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
    }else{
        if (request.tag == BUY_TYPE) {
            
            BuyAddModel* bm=[[BuyAddModel alloc]initWithDictionary:dictionary];
            
            if (bm.result==0) {
//                [self dismiss];
                if (_delegate && [_delegate respondsToSelector:@selector(dismissProgramPackage)]) {
                    [_delegate dismissProgramPackage];
                }
                [self dismiss];
                UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"购买成功！" delegate:[AppDelegate App].window.rootViewController.view cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alvIew show];
                return;
            }else if(bm.result == 107){
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:@"您的余额不足，现在去充值？" delegate:self cancelButtonTitle:@"稍后再充" otherButtonTitles:@"现在就去", nil];
                alert.tag = 501;
                [alert show];
            }
            else
            {
                [Commonality showErrorMsg:self type:bm.result msg:@"网络连接异常！"];
            }
        }

        [_proInfoArr removeAllObjects];
        ProductInfoModel * proInfoModel = [[ProductInfoModel alloc] initWithDictionary:dictionary modelList:_proInfoArr page:1];
        
        if (proInfoModel.result==0) {
            CHECK_NONERETURN(_proInfoArr.count > 0);
            if (_proInfoArr.count == 0) {
                
            }
            ProductInfoModel * proInfoModel = [_proInfoArr objectAtIndex:0];
            produtTitle.text = proInfoModel.productTitle;
            procutPoint.text = [NSString stringWithFormat:@"%@猫币",proInfoModel.points];
            [self.myTableView reloadData];
            
        }
    }

}
@end
