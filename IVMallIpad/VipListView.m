//
//  VipListView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-7.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "VipListView.h"
#import "AppDelegate.h"
#import "BuyListModel.h"
#import "BuyVipView.h"

@implementation VipListView

-(id)initMy{
    if (self=[super init]) {
        
        
        _tableArr = [[NSMutableArray alloc] init];
        rect=[[UIScreen mainScreen] bounds];
        _pageNum = 1;
        
        _myView=[[UIView alloc]initWithFrame:rect];
        _myView.alpha=0.1;
        _myView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissALLView)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
        self.frame=CGRectMake(152, rect.size.height-550,400 , rect.size.width-44-[AppDelegate App].countIOS7);
        self.backgroundColor=[Commonality colorFromHexRGB:@"d2d2d2"];
        tmpRect=self.frame;
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 50)];
        heatView.backgroundColor=[Commonality colorFromHexRGB:HEADVIEW_BACKGROUND_COLOR];
        
        UIButton * btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [btn addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        btn.frame=CGRectMake(30, 10, 30, 30);
        [heatView addSubview:btn];
        
        UILabel*titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 40)];
        titleLabe.textColor=[UIColor whiteColor];
        titleLabe.text=@"开通会员";
        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
        titleLabe.textAlignment=NSTextAlignmentCenter;
        titleLabe.backgroundColor=[UIColor clearColor];
        [heatView addSubview:titleLabe];
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, 400, rect.size.width-44-[AppDelegate App].countIOS7-50)];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [self addSubview:_tableView];
        
        [self addSubview:_myView];
        [self addSubview:heatView];
        
        
        _header = [MJRefreshHeaderView header];
        _header.scrollView = self.tableView;
        _header.delegate = self;
        
        
        // 4.3行集成上拉加载更多控件
        _footer = [MJRefreshFooterView footer];
        _footer.scrollView = self.tableView;
        // 进入上拉加载状态就会调用这个方法
        
        __block VipListView * selfview = self;
        _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
                
                
                [selfview reloadDeals];
                [Commonality showErrorMsg:selfview type:104 msg:nil];
            }else{
                
                if (selfview.tableArr.count == 0) {
//                    [HttpRequest vipListRequest:1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
                else
                {
//                    [HttpRequest vipListRequest:selfview.pageNum delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
            }
        };
        
        
    }
    return self;
}

-(void)dismissALLView
{
    [Commonality dismissAllView];
}

#pragma mark 刷新
- (void)reloadDeals{
    [_header endRefreshing];
    [_footer endRefreshing];
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([Commonality isEmpty:AppDelegate.App.personModel.tokenid]) {
        [_header performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
        [Commonality showErrorMsg:self type:104 msg:nil];
        return;
    }
    if (refreshView == _header) { // 下拉刷新
        
//        [HttpRequest vipListRequest:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self performSelector:@selector(showMyRechargeView) withObject:nil afterDelay:1];
    }
}

-(void)showMyRechargeView
{
//    if ([AppDelegate App].rechargeView == nil) {
//        [AppDelegate App].rechargeView = [[RechargeView alloc] initMy];
//    }
//    [Commonality anmou1View:[AppDelegate App].rechargeView delegate:[AppDelegate App].tabBarController];
//    [[AppDelegate App].rechargeView show];
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CHECK_NONERETURN(_tableArr.count > indexPath.row);
    BuyListModel * payListM = [_tableArr objectAtIndex:indexPath.row];
    if ([[AppDelegate App].personModel.balance floatValue] < payListM.points) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您的猫币不足" message:@"现在去充值？" delegate:self cancelButtonTitle:@"稍后再去" otherButtonTitles:@"现在就去", nil];
        [alert show];
        return;
    }
    
    BuyVipView * buyVip = [[BuyVipView alloc] initMy];
    buyVip.vipID = payListM.productId;
    buyVip.points =[NSString stringWithFormat:@"%0.2f",payListM.points];
    buyVip.vipTitle = payListM.productTitle;
    [Commonality anmou1View:buyVip delegate:[AppDelegate App].tabBarController];
    [buyVip show];
    
//    [HttpRequest BuyVipRequest:[AppDelegate App].personModel.tokenid vipGuid:payListM.productId points:[NSString stringWithFormat:@"%0.2f",payListM.points] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * myCell = @"MYCELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CHECK_RETURN_CELL(_tableArr.count > indexPath.row, cell);
    BuyListModel * payListM = [_tableArr objectAtIndex:indexPath.row];
    UILabel * pointLab =(UILabel *) [cell viewWithTag:500] ;
    if (pointLab == nil) {
        pointLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 300, 30)];
        pointLab.tag = 500;
        pointLab.font = [UIFont boldSystemFontOfSize:15];
        pointLab.backgroundColor = [UIColor clearColor];
        [cell addSubview:pointLab];
    }
    pointLab.text = payListM.productTitle;

    UILabel * pointLab1 =(UILabel *) [cell viewWithTag:502] ;
    if (pointLab1 == nil) {
        pointLab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 300, 30)];
        pointLab1.tag = 502;
        pointLab1.font = [UIFont boldSystemFontOfSize:13];
        pointLab1.backgroundColor = [UIColor clearColor];
        pointLab1.textColor = [Commonality colorFromHexRGB:@"ef3363"];
        [cell addSubview:pointLab1];
    }
    pointLab1.text = [NSString stringWithFormat:@"%0.2f猫币",payListM.points];

    UILabel * payTimeLab = (UILabel *)[cell viewWithTag:501];
    if (payTimeLab == nil) {
        payTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 55, 350, 30)];
        payTimeLab.tag = 501;
        payTimeLab.font = [UIFont boldSystemFontOfSize:13];
        payTimeLab.backgroundColor = [UIColor clearColor];
        payTimeLab.textColor = [UIColor lightGrayColor];
        [cell addSubview:payTimeLab];
    }
    payTimeLab.text = payListM.productDescription;
    
    UIView * line = [cell viewWithTag:503];
    if (line == nil) {
        line = [[UIView alloc] initWithFrame:CGRectMake(30, 89, 500, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.tag = 503;
        [cell addSubview:line];
    }
    
    cell.backgroundColor = [Commonality colorFromHexRGB:@"d2d2d2"];
    cell.contentView.backgroundColor = [Commonality colorFromHexRGB:@"d2d2d2"];;
    return cell;
}

-(void)show{
    _hihel=YES;
//    [HttpRequest vipListRequest:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    self.center=CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height/2);
                     }];
    
    UIWindow*wind=[UIApplication sharedApplication].keyWindow;
    self.transform = CGAffineTransformMakeRotation(90 * (M_PI / 180.0f));
    [wind addSubview:_myView];
    [wind addSubview:self];
}

-(void)dismiss{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height+30);
                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                     }];
}

-(void) GetErr:(ASIHTTPRequest *)request
{
    [self reloadDeals];
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    [self reloadDeals];
    NSData *responseData = [request responseData];
    
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
        
    }else{
        
        if (request.tag == BUYVIP_TYPE) {
            [Commonality showErrorMsg:self type:0 msg:@"购买成功"];
            [self dismiss];
//            [[AppDelegate App].userView makeLogInView];
        }
        else
        {
            BuyListModel * fm = [[BuyListModel alloc] initWithVipListDictionary:dictionary modelList:_tableArr page:request.tag];
            if (fm.result==0) {
                _pageNum=request.tag;
                [_tableView reloadData];
                if ([_tableArr count]==0) {
                    //                [Commonality showErrorMsg:self type:0 msg:@"!"];
                    //                imgView.hidden = NO;
                    //                mesageLabel.hidden = NO;
                }
            }
            else
            {
                //            imgView.hidden = YES;
                //            mesageLabel.hidden = YES;
                [Commonality showErrorMsg:self type:fm.result msg:nil];
            }

            
        }
        
           }
    
}

-(NSString *)setTime:(NSString *)timeStr
{
    NSString* string = timeStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    return [NSString stringWithFormat:@"充值时间:%@",str1];
}

@end
