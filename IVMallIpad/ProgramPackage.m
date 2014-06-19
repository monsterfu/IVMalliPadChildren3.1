//
//  ProgramPackage.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-11.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ProgramPackage.h"
#import "Commonality.h"
#import "AppDelegate.h"
#import "HttpRequest.h"
#import "ContentProductListModel.h"
#import "UIButton+Bootstrap.h"
#import "BuyListModel.h"


@implementation ProgramPackage

-(id)initWithVipArr:(NSMutableArray *)VipArr andProgramDic:(NSMutableArray *)programArr
{
    if (self=[super init]) {
//        _vipArr = [[NSMutableArray alloc] initWithArray:VipArr];
//        _programArr = [[NSMutableArray alloc] initWithArray:programArr];
        _isVipList = NO;
        _vipArr = [[NSMutableArray alloc] init];
        _programArr = [[NSMutableArray alloc] init];
        
        rect=[[UIScreen mainScreen]bounds];
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = CGRectZero;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
        backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 13, 156)];
        backgroundImgView.image = [UIImage imageNamed:@"openingMembership.png"];
        [self addSubview:backgroundImgView];
        
        

        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2- 25, 20, 100, 30)];
        lab.text = @"开通会员";
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.backgroundColor = [UIColor clearColor];
        [self addSubview:lab];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, 25, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"X.png"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, rect.size.height - 400, rect.size.width- 50 - 40) ];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor=[UIColor clearColor];
        _myTableView.separatorStyle=NO;
        [_myTableView registerNib:[UINib nibWithNibName:@"ProgramVipCell" bundle:nil] forCellReuseIdentifier:@"MyVipCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ProgramCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
        
        [self addSubview:_myTableView];
        
//        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        tap.numberOfTapsRequired=1;
//        [_myView addGestureRecognizer:tap];
//        gao,chang,y,x

        self.frame=CGRectMake(-128 + 200, 128 + 25, rect.size.height - 400, rect.size.width- 50);
        self.backgroundColor=[UIColor whiteColor];
        [Commonality setImgViewStyle:self];
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)show{
   
    if (_isShowFromMain == NO) {
        self.viewCtl = [AppDelegate App].personView;
        PersonnalCenter * per = (PersonnalCenter *)[AppDelegate App].personView;
        
        if (self.viewCtl.view.subviews.count > 2) {
            UIView * view1 = [per.view.subviews lastObject];
            
            if (view1 != per.userView) {
                //view1.hidden = YES;
            }
            
        }
        
        if (_isVipList) {
            [HttpRequest vipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        else
        {
            [HttpRequest productListRequest:[AppDelegate App].personModel.tokenid contentGuid:self.productId delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        _myView.frame = CGRectMake(0, 0, self.viewCtl.view.frame.size.width, self.viewCtl.view.frame.size.height);
        _myView.alpha = 0.5;
        [self.viewCtl.view addSubview:_myView];
        self.frame = CGRectMake(self.viewCtl.view.frame.size.height/2 - (rect.size.height - 400)/2, self.viewCtl.view.frame.size.width/2- (rect.size.width- 50)/2 + 30, rect.size.height - 400, rect.size.width- 50 - 30);
        backgroundImgView.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [self.viewCtl.view addSubview:self];
        self.center =self.viewCtl.view.center;
    }
    else
    {
        UIViewController * main = [AppDelegate App].tabBarController;
        
        if (main.view.subviews.count > 2) {
            UIView * view1 = [main.view.subviews lastObject];
//            UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
            if (view1 != [AppDelegate App].tabBarController.customContentView) {
                view1.hidden = YES;
            }
//            if (view2 != [AppDelegate App].tabBarController.customContentView) {
//                view2.hidden = YES;
//            }
        }
        
        if (_isVipList) {
            [HttpRequest vipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        else
        {
            [HttpRequest productListRequest:[AppDelegate App].personModel.tokenid contentGuid:self.productId delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        
        _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _myView.alpha = 0.5;
        [main.view addSubview:_myView];
        self.frame = CGRectMake(main.view.frame.size.width/2 - (main.view.frame.size.width - 400)/2, main.view.frame.size.height/2- (main.view.frame.size.height- 50)/2 + 30, main.view.frame.size.width - 400, main.view.frame.size.height- 50 - 30);
        backgroundImgView.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [main.view addSubview:self];
        
    }
    
    if ([AppDelegate App].isLogin) {
        [HttpRequest UserInfoRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    
}

-(void)dismiss
{
    
    
//    if (_buyVipDelegate && [_buyVipDelegate respondsToSelector:@selector(buyVipViewWillDismiss)]) {
//        [_buyVipDelegate buyVipViewWillDismiss];
//    }
    if (_isShowFromMain == NO) {
        PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
        UIViewController * main = self.viewCtl;
        [_myView removeFromSuperview];
        [self removeFromSuperview];
        
        
        UIView * view1 = [main.view.subviews lastObject];
        UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
        view1.hidden = NO;
        view2.hidden = NO;
        
        if ([view1 isKindOfClass:[UserView class]]) {
            [per.userView.myTableView reloadData];
        }
        if ([view2 isKindOfClass:[UserView class]]) {
            [per.userView.myTableView reloadData];
        }

    }
    else
    {
        UIViewController * main = [AppDelegate App].tabBarController;
        [_myView removeFromSuperview];
        [self removeFromSuperview];
        
        
        UIView * view1 = [main.view.subviews lastObject];
        UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
        view1.hidden = NO;
        view2.hidden = NO;
        PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
        if ([view1 isKindOfClass:[UserView class]]) {
            [per.userView.myTableView reloadData];
        }
        if ([view2 isKindOfClass:[UserView class]]) {
            [per.userView.myTableView reloadData];
        }
    }

    
}

-(void)clickBuyVipBtn:(int)tag
{
    if (buyVip == nil) {
        buyVip = [[BuyVipView alloc] initMy];
    }
    buyVip.delegate = self;
    CHECK_NONERETURN(_vipArr.count > tag);
//    VipModel * vip = [_vipArr objectAtIndex:tag];
//    buyVip.vipTitle = vip.vipTitle;
//    buyVip.points = [NSString stringWithFormat:@"%0.2f",vip.points];
//    buyVip.vipID = vip.vipGuid;
    if (_isVipList) {
        BuyListModel * payListM  = [_vipArr objectAtIndex:tag];
        buyVip.vipTitle = payListM.productTitle;
        buyVip.points = [NSString stringWithFormat:@"%0.2f",payListM.points];
        buyVip.vipID = payListM.productId;
    }
    else
    {
        VipModel * vip = [_vipArr objectAtIndex:tag];
        buyVip.vipTitle = vip.vipTitle;
        buyVip.points = [NSString stringWithFormat:@"%0.2f",vip.points];
        buyVip.vipID = vip.vipGuid;
    }
    [Commonality anmou1View:buyVip delegate:[AppDelegate App].tabBarController];
    buyVip.isFromMainShowing = _isShowFromMain;
    
    if (_isShowFromMain == NO) {
//        PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
        buyVip.buyVipDelegate =(PersonnalCenter *)self.viewCtl;
    }
    [buyVip show];
    
}

-(void)clickProgramBtn:(int)tag
{
    if (proInfo == nil) {
        proInfo = [[productInfoView alloc] initWithFrame:self.frame];
    }
    proInfo.delegate = self;
    CHECK_NONERETURN(_programArr.count > tag);
    ProductModel * proModel = [_programArr objectAtIndex:tag];
    proInfo.productId = proModel.productGuid;
    [Commonality anmou1View:proInfo delegate:[AppDelegate App].tabBarController];
    [proInfo show];
}

#pragma mark showProgramPackageDelegate
-(void)showProgramPackage
{
//    UIViewController * main = [AppDelegate App].tabBarController;
//    UIView * view1 = [main.view.subviews lastObject];
//    UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
//    view1.hidden = NO;
//    view2.hidden = NO;
    
//    if ([view1 isKindOfClass:[UserView class]]) {
//        [[AppDelegate App].userView makeLogInView];
//    }
//    if ([view2 isKindOfClass:[UserView class]]) {
//        [[AppDelegate App].userView makeLogInView];
//    }
    [self dismiss];
    PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
    [per.userView makeLogInView];
    [per.userView.myTableView reloadData];
}

#pragma mark dismissProgramPackage
-(void)dismissProgramPackage
{
    [self dismiss];
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![AppDelegate App].isLogin) {
        PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
        if (per.userView == nil) {
            per.userView = [[UserView alloc] init];
        }
        [per.userView show];
        return;
    }
    
    if (indexPath.section == 0) {
        if (buyVip == nil) {
            buyVip = [[BuyVipView alloc] initMy];
        }
        buyVip.delegate = self;
        CHECK_NONERETURN(_vipArr.count > indexPath.row);
        if (_isVipList) {
            BuyListModel * payListM  = [_vipArr objectAtIndex:indexPath.row];
            buyVip.vipTitle = payListM.productTitle;
            buyVip.points = [NSString stringWithFormat:@"%0.2f",payListM.points];
            buyVip.vipID = payListM.productId;
        }
        else
        {
            VipModel * vip = [_vipArr objectAtIndex:indexPath.row];
            buyVip.vipTitle = vip.vipTitle;
            buyVip.points = [NSString stringWithFormat:@"%0.2f",vip.points];
            buyVip.vipID = vip.vipGuid;
        }
        
        buyVip.isFromMainShowing = _isShowFromMain;
//        [Commonality anmou1View:buyVip delegate:[AppDelegate App].tabBarController];
        
        
        if (_isShowFromMain == NO) {
            //        PersonnalCenter * per = (PersonnalCenter *)self.viewCtl;
            buyVip.buyVipDelegate =(PersonnalCenter *)self.viewCtl;
        }
        [Commonality anmou1View:buyVip delegate:[AppDelegate App].tabBarController];
        [buyVip show];
        
//        [buyVip show];
    }
    if (indexPath.section == 1) {
        if (proInfo == nil) {
            proInfo = [[productInfoView alloc] initWithFrame:self.frame];
        }
        CHECK_NONERETURN(_programArr.count > indexPath.row);
        proInfo.delegate = self;
        ProductModel * proModel = [_programArr objectAtIndex:indexPath.row];
        proInfo.productId = proModel.productGuid;
        [Commonality anmou1View:proInfo delegate:[AppDelegate App].tabBarController];
        [proInfo show];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 87;
    }
    return 156;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_programArr.count > 0) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _vipArr.count;
    }
    return _programArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    view.backgroundColor = [UIColor whiteColor];

    UIView * view2;
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 150, 30)];
    if (section == 0) {
        lab.text = @"开通会员";
        view2 = [[UIView alloc] initWithFrame:CGRectMake(110, 15, tableView.frame.size.width - 150, 1)];
    }
    else
    {
        lab.text = @"购买节目套餐";
        view2 = [[UIView alloc] initWithFrame:CGRectMake(140, 15, tableView.frame.size.width - 180, 1)];
    }
    lab.textColor = color_2;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont boldSystemFontOfSize:17];
    [view addSubview:lab];
    view2.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:view2];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * myVipCell = @"MyVipCell";
    static NSString * myCell = @"MyCell";
    if (indexPath.section == 0) {
        ProgramVipCell * cell = [tableView dequeueReusableCellWithIdentifier:myVipCell];
        if (cell == nil) {
            cell = [[ProgramVipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myVipCell];
        }
        if (_isVipList) {
            CHECK_RETURN_CELL(_vipArr.count > indexPath.row, cell);
            BuyListModel * payListM = [_vipArr objectAtIndex:indexPath.row];
            cell.titleLab.text = payListM.productTitle;
            cell.pointLab.text = [NSString stringWithFormat:@"%0.2f猫币",payListM.points];
            cell.descriptionLab.text = payListM.productDescription;
            cell.pointLab.textColor = [Commonality colorFromHexRGB:@"ef3463"];
            cell.buyBtn.tag = indexPath.row;
            [cell.buyBtn redStyle];
//            cell.buyBtn.backgroundColor = color_6;
////            [cell.buyBtn removeFromSuperview];
//            if (cell.btnBackView == nil) {
//                cell.btnBackView = [Commonality makeButtonShadowViewWhitbtn:cell.buyBtn];
////                [cell.btnBackView addSubview:cell.buyBtn];
//            }
            
            
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            return cell;
        }
        CHECK_RETURN_CELL(_vipArr.count > indexPath.row, cell);
        VipModel * vipModel = [_vipArr objectAtIndex:indexPath.row];
        cell.titleLab.text = vipModel.vipTitle;
        cell.pointLab.text = [NSString stringWithFormat:@"%0.2f猫币",vipModel.points];
        cell.descriptionLab.text = vipModel.vipDescription;
        cell.pointLab.textColor = [Commonality colorFromHexRGB:@"ef3463"];
        cell.buyBtn.tag = indexPath.row;
        [cell.buyBtn redStyle];
//        cell.buyBtn.backgroundColor = color_6;
//        [cell.buyBtn removeFromSuperview];
//        [cell.buyBtn childrenBtnStyle];
//        cell.btnBackView = [Commonality makeButtonShadowViewWhitbtn:cell.buyBtn];
//        cell.buyBtn.tag = indexPath.row;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        return cell;
    }
  
    ProgramCell * cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[ProgramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    CHECK_RETURN_CELL(_programArr.count > indexPath.row, cell);
    ProductModel * proModel = [_programArr objectAtIndex:indexPath.row];
    cell.titleLab.text = proModel.productTitle;
    cell.pointLab.text = [NSString stringWithFormat:@"%0.2f猫币",proModel.points];
    cell.sourceLab.text = [NSString stringWithFormat:@"来源：%@",proModel.productFrom];//proModel.productFrom
    cell.descriptionLab.text = proModel.productDescription;
    cell.programCountLab.text = [NSString stringWithFormat:@"节目：%d个",proModel.contentCount];
    cell.pointLab.textColor = [Commonality colorFromHexRGB:@"ef3463"];
    
    cell.buyBtn.tag = indexPath.row;
    [cell.buyBtn blueStyle];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"error is %@",error);
//    NSString*str=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
    }else{
        if (request.tag == USERINFOURL_TYPE){
            AppDelegate.App.personModel.balance = [[dictionary objectForKey:@"data"] objectForKey:@"balance"];
        }
        else if (request.tag == VIPLIST_TYPE)
        {
            [_programArr removeAllObjects];
            [_vipArr removeAllObjects];
            
            BuyListModel * fm = [[BuyListModel alloc] initWithVipListDictionary:dictionary modelList:_vipArr page:1];
            if (fm.result==0) {
                [_myTableView reloadData];
            }
            else
            {
                [Commonality showErrorMsg:self type:fm.result msg:nil];
            }
        }
        
        else{
            [_programArr removeAllObjects];
            [_vipArr removeAllObjects];
        
            ContentProductListModel * chan = [[ContentProductListModel alloc] initWithDictionary:dictionary andVipArr:_vipArr :_programArr];

            if (chan.result==0) {
                [self.myTableView reloadData];
            }
        }
    }
}

@end
