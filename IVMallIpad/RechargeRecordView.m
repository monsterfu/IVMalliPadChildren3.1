//
//  RechargeRecordView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-6.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "RechargeRecordView.h"
#import "AppDelegate.h"
#import "PayListModel.h"

@implementation RechargeRecordView

-(id)initMyWithFram:(CGRect)NewRect{
    if (self=[super init]) {
        
        _isShowing = NO;
        _tableArr = [[NSMutableArray alloc] init];
        rect=[[UIScreen mainScreen] bounds];
        _pageNum = 1;
        
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissALLView)];//
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
        self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
        self.frame = NewRect;
        self.backgroundColor=color_21;
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, NewRect.size.width, 50)];
        heatView.backgroundColor=color_18;
        
        _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 70, heatView.frame.size.height)];
        _typeLab.backgroundColor = [UIColor clearColor];
        _typeLab.text = @"充值方式";
        _typeLab.font = [UIFont systemFontOfSize:16];
        [heatView addSubview:_typeLab];
        
        _pointLab = [[UILabel alloc] initWithFrame:CGRectMake(_typeLab.frame.origin.x + _typeLab.frame.size.width + 90, 0, 70, heatView.frame.size.height)];
        _pointLab.backgroundColor = [UIColor clearColor];
        _pointLab.text = @"点数";
        _pointLab.font = [UIFont systemFontOfSize:16];
        [heatView addSubview:_pointLab];
        
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(_pointLab.frame.origin.x + _pointLab.frame.size.width + 90, 0, 70, heatView.frame.size.height)];
        _timeLab.backgroundColor = [UIColor clearColor];
        _timeLab.text = @"充值时间";
        _timeLab.font = [UIFont systemFontOfSize:16];
        [heatView addSubview:_timeLab];
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, heatView.frame.size.height, NewRect.size.width,NewRect.size.height - heatView.frame.size.height)];
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
        
        __block RechargeRecordView * selfview = self;
        _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
                
                
                [selfview reloadDeals];
                [Commonality showErrorMsg:selfview type:104 msg:nil];
            }else{
                
                if (selfview.tableArr.count == 0) {
                    [HttpRequest PayListRequest:AppDelegate.App.personModel.tokenid page:1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
                else
                {
                    [HttpRequest PayListRequest:AppDelegate.App.personModel.tokenid page:selfview.pageNum + 1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
            }
        };

          tmpRect=self.frame;
        
        _nodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, NewRect.size.width, 350)];
        _nodataView.backgroundColor = [UIColor clearColor];
        [_tableView addSubview:_nodataView];
        _nodataView.hidden = YES;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(NewRect.size.width/2 - 150, 0, 300, 300)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"充值.png"];
        [_nodataView addSubview:imageView];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, _nodataView.frame.size.width, 30)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"当前没有充值记录";
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.alpha = 0.48;
        lab.font = [UIFont boldSystemFontOfSize:23];
        [_nodataView addSubview:lab];
    }
    return self;
}
//
-(void)dismissALLView
{
    [Commonality dismissAllView];
}
//
#pragma mark 刷新
- (void)reloadDeals
{
    
    [_header endRefreshing];
    [_footer endRefreshing];
    
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if ([Commonality isEmpty:AppDelegate.App.personModel.tokenid]) {
        [_header performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
        [Commonality showErrorMsg:self type:104 msg:nil];
        return;
    }
    if (refreshView == _header) { // 下拉刷新
        [HttpRequest PayListRequest:AppDelegate.App.personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * myCell = @"MYCELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row > _tableArr.count) {
        return cell;
    }
    PayListModel * payListM = [_tableArr objectAtIndex:indexPath.row];
    UILabel * pointLab =(UILabel *) [cell viewWithTag:500] ;
    if (pointLab == nil) {
        pointLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 160, 30)];
        pointLab.tag = 500;
        pointLab.font = [UIFont boldSystemFontOfSize:15];
        pointLab.backgroundColor = [UIColor clearColor];
        [cell addSubview:pointLab];
    }
    if ([payListM.type isEqualToString:@"gift"]) {
        pointLab.text = [NSString stringWithFormat:@"赠送"];
    }
    else if ([payListM.type isEqualToString:@"alipay"])
    {
        pointLab.text = [NSString stringWithFormat:@"支付充值"];
    }
    else
    {
        pointLab.text = [NSString stringWithFormat:@"点卡充值"];
    }
    
    
    UILabel * pointLab1 =(UILabel *) [cell viewWithTag:502] ;
    if (pointLab1 == nil) {
        pointLab1 = [[UILabel alloc] initWithFrame:CGRectMake(_pointLab.frame.origin.x, 15, 160, 30)];
        pointLab1.tag = 502;
        pointLab1.font = [UIFont boldSystemFontOfSize:13];
        pointLab1.backgroundColor = [UIColor clearColor];
        pointLab1.textColor = [Commonality colorFromHexRGB:@"ef3363"];
        [cell addSubview:pointLab1];
    }
    pointLab1.text = [NSString stringWithFormat:@"%0.2f猫币",payListM.points];
    
    UILabel * payTimeLab = (UILabel *)[cell viewWithTag:501];
    if (payTimeLab == nil) {
        payTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(_timeLab.frame.origin.x, 15, 160, 30)];
        payTimeLab.tag = 501;
        payTimeLab.font = [UIFont boldSystemFontOfSize:11];
        payTimeLab.backgroundColor = [UIColor clearColor];
        payTimeLab.textColor = [UIColor blackColor];
        payTimeLab.alpha = 0.4;
        [cell addSubview:payTimeLab];
    }
    payTimeLab.text = [NSString stringWithFormat:@"%@",[self setTime:payListM.createTime]];
    
    UIView * line = [cell viewWithTag:503];
    if (line == nil) {
        line = [[UIView alloc] initWithFrame:CGRectMake(30, 60, 600, 0.5)];
        line.backgroundColor = color_18;
        line.tag = 503;
        [cell addSubview:line];
    }
    
    cell.backgroundColor = color_21;
    cell.contentView.backgroundColor = color_21;
    return cell;
}

-(void)show{
    _hihel=YES;
    _nodataView.hidden = YES;
    [HttpRequest PayListRequest:AppDelegate.App.personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.width-44-[AppDelegate App].countIOS7);
//                         _myView.alpha = 0;
//                     }];
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
}

-(void)dismiss{
    [HttpRequest myCancelAsi];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400 , [AppDelegate App].countIOS7 + 44,400 , rect.size.width-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0;
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
    NSLog(@"dic is %@",dictionary);
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
        
    }else{
        PayListModel* fm=[[PayListModel alloc]initWithDictionary:dictionary modelList:_tableArr page:request.tag];
        if (fm.result==0) {
            _pageNum=request.tag;
            if (_pageNum == 1) {
                [HttpRequest PayListRequest:AppDelegate.App.personModel.tokenid page:2 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }else{
                [_tableView reloadData];
            }
            if ([_tableArr count]==0) {
                _nodataView.hidden = NO;
//            [Commonality showErrorMsg:self type:0 msg:@"你当前没有充值记录!"];
//                imgView.hidden = NO;
//                mesageLabel.hidden = NO;
            }
        }else{
            _nodataView.hidden = YES;
//            imgView.hidden = YES;
//            mesageLabel.hidden = YES;
            [Commonality showErrorMsg:self type:fm.result msg:nil];
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
    return [NSString stringWithFormat:@"%@",str1];
}
@end
