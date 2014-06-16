////




//
//  BuyView.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-25.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "BuyView.h"
#import "AppDelegate.h"
#import "BuyListModel.h"
@implementation BuyView

-(id)initMyWithFrame:(CGRect )newRect
{
    if (self=[super init]) {
        
        _isShowing = NO;
        self.pageNum=1;
        
        self.vipPageNum = 1;
        _isVipType = YES;
        _vipTableArray = [[NSMutableArray alloc] init];
        
        _tableArray=[[NSMutableArray alloc]init];
        rect=[[UIScreen mainScreen]bounds];
        
        
        
        self.frame = newRect;
        tmpRect=self.frame;
        self.backgroundColor=color_21;
        
        
        vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        vipBtn.frame = CGRectMake(0, 0, newRect.size.width/2, 50);
        [vipBtn setTitle:@"会员套餐" forState:UIControlStateNormal];
        vipBtn.backgroundColor = color_21;
        vipBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [vipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        vipBtn.titleLabel.alpha = 0.8;
        vipBtn.tag = 500;
        [vipBtn addTarget:self action:@selector(comboChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:vipBtn];
        
        programBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        programBtn.frame = CGRectMake(newRect.size.width/2, 0, newRect.size.width/2, 50);
        [programBtn setTitle:@"节目套餐" forState:UIControlStateNormal];
        programBtn.backgroundColor = color_18;
        programBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [programBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        programBtn.titleLabel.alpha = 0.8;
        programBtn.tag = 501;
        [programBtn addTarget:self action:@selector(comboChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:programBtn];
        
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, newRect.size.width, newRect.size.height - 50)];
        _tabelView.backgroundColor=[UIColor clearColor];
        _tabelView.separatorStyle=NO;
        _tabelView.dataSource=self;
        _tabelView.delegate=self;
        
        [_tabelView registerNib:[UINib nibWithNibName:@"BuyListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        [_tabelView registerNib:[UINib nibWithNibName:@"BuyVipListCell" bundle:nil] forCellReuseIdentifier:@"VipCell"];
        
        [self addSubview:_tabelView];
        
        
        
        
        _header = [MJRefreshHeaderView header];
        _header.scrollView = self.tabelView;
        _header.delegate = self;
        
        // 4.3行集成上拉加载更多控件
        _footer = [MJRefreshFooterView footer];
        _footer.scrollView = self.tabelView;
        // 进入上拉加载状态就会调用这个方法
        
        __block BuyView * selfview = self;
        _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
                [selfview reloadDeals];
                [Commonality showErrorMsg:selfview type:104 msg:nil];
            }else{
                if (!selfview.isVipType) {
                    
                    
                    if (selfview.tableArray.count==0) {
                        [HttpRequest BuyListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                    }else{
                        [HttpRequest BuyListRequest:[AppDelegate App].personModel.tokenid page:selfview.pageNum+1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                    }
                }
                else
                {
                    if (selfview.vipTableArray.count == 0) {
                        [HttpRequest BuyVipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                    }
                    else
                    {
                        [HttpRequest BuyVipListRequest:[AppDelegate App].personModel.tokenid page:selfview.vipPageNum + 1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                    }
                }
                
                
            }
        };
        
        
        
        _nodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, newRect.size.width, 350)];
        _nodataView.backgroundColor = [UIColor clearColor];
        [_tabelView addSubview:_nodataView];
        _nodataView.hidden = YES;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 150, 0, 300, 300)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"buy.png"];
        [_nodataView addSubview:imageView];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, _nodataView.frame.size.width, 30)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"当前没有购买记录";
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.alpha = 0.48;
        lab.font = [UIFont boldSystemFontOfSize:23];
        [_nodataView addSubview:lab];
    }
    return self;
}

-(void)dismissALLView
{
    [Commonality dismissAllView];
}

-(void)comboChoose:(UIButton *)btn;
{
    
    if (btn.tag == 500) {
        _isVipType = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
//        _indicatorLab1.frame = CGRectMake(0, _indicatorLab1.frame.origin.y, 200, 3);
        vipBtn.backgroundColor = color_21;
        programBtn.backgroundColor = color_18;
        [UIView commitAnimations];
        [_tabelView reloadData];
        if (_vipTableArray.count == 0) {
            [HttpRequest BuyVipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        if (_vipTableArray.count == 0) {
            _nodataView.hidden = NO;
        }
        else
        {
            _nodataView.hidden = YES;
        }
        return;
    }
    else
    {
        _isVipType = NO;
        
 
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
//        _indicatorLab1.frame = CGRectMake(200, _indicatorLab1.frame.origin.y, 200, 3);
        vipBtn.backgroundColor = color_18;
        programBtn.backgroundColor = color_21;
        [UIView commitAnimations];
        
   
        [_tabelView reloadData];
        if (_tableArray.count==0) {
            [HttpRequest BuyListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        if (_tableArray.count == 0) {
            _nodataView.hidden = NO;
        }
        else
        {
            _nodataView.hidden = YES;
        }
        return;
    }
    
}


#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"refreshViewBeginRefreshing");
    if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
        [self reloadDeals];
        [Commonality showErrorMsg:self type:104 msg:nil];
        return;
    }
    
    if (refreshView == _header) { // 下拉刷新
        
        if (_isVipType) {
            [HttpRequest BuyVipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        else
        {
            [HttpRequest BuyListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        
        
    }
}

#pragma mark -
#pragma mark UITableView Datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 105;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    if (_isVipType) {
        return _vipTableArray.count;
    }
    
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier1 = @"VipCell";
    static NSString * cellIdentifier2 = @"Cell";
    
    if (_isVipType) {
        BuyVipListCell * cell = [_tabelView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[BuyVipListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.userInteractionEnabled = NO;
        }
        CHECK_RETURN_CELL(_vipTableArray.count > indexPath.row, cell);
        BuyListModel * buyModel = [_vipTableArray objectAtIndex:indexPath.row];
        cell.titleLab.text = buyModel.productTitle;
        cell.balanceLab.text = [NSString stringWithFormat:@"%0.2f猫币",buyModel.points];
        cell.buyTimeLab.text =  [NSString stringWithFormat:@"购买时间:%@",[self setTime:buyModel.buyTime]];
        cell.dueTimeLab.text = [NSString stringWithFormat:@"到期时间:%@",[self setTime:buyModel.dueTime]];
        cell.contentView.backgroundColor = color_21;
        cell.backgroundColor = color_21;
        cell.balanceLab.textColor = [Commonality colorFromHexRGB:@"e32957"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        BuyListCell * cell = [_tabelView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[BuyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.userInteractionEnabled = NO;
            
        }
        CHECK_RETURN_CELL(_tableArray.count > indexPath.row, cell);
        BuyListModel * buyModel = [_tableArray objectAtIndex:indexPath.row];
        cell.titleLab.text = buyModel.productTitle;
        cell.balanceLab.text = [NSString stringWithFormat:@"%0.2f猫币",buyModel.points];
        cell.buyTimeLab.text = [NSString stringWithFormat:@"购买时间:%@",[self setTime:buyModel.buyTime]];
        cell.dueTimeTab.text = [NSString stringWithFormat:@"到期时间:%@",[self setTime:buyModel.dueTime]];
        cell.contentView.backgroundColor = color_21;
        cell.backgroundColor = color_21;
        cell.balanceLab.textColor = [Commonality colorFromHexRGB:@"e32957"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

#pragma mark 刷新
- (void)reloadDeals
{
    
    [_header endRefreshing];
    [_footer endRefreshing];
    
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [self reloadDeals];
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}


-(void) GetResult:(ASIHTTPRequest *)request{
    [self reloadDeals];
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"dic is %@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);

    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
    }else{
        [self paysingBuyInfo:dictionary Result:request.tag];
    }
}

-(void)paysingBuyInfo:(NSDictionary*)dictionary Result:(int)cont{
    BuyListModel* fm;
    
    if (_isVipType) {
        fm = [[BuyListModel alloc] initWithVipDictionary:dictionary modelList:_vipTableArray page:cont];
        if (_vipTableArray.count == 0) {
            _nodataView.hidden = NO;
        }
        else
        {
            _nodataView.hidden = YES;
        }
//        [_tabelView reloadData];
    }
    else
    {
        fm =[[BuyListModel alloc]initWithDictionary:dictionary modelList:_tableArray page:cont];
        if (_tableArray.count == 0) {
            _nodataView.hidden = NO;
        }
        else
        {
            _nodataView.hidden = YES;
        }
//        [_tabelView reloadData];
    }
    
    if (fm.result==0) {
        
        if (_isVipType) {
            _vipPageNum = cont;
        }
        else
        {
            _pageNum = cont;
        }
        
        if (cont==1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dictionary forKey:[NSString stringWithFormat:@"buyRecord"]];
            [userDefaults synchronize];
        }
        [_tabelView reloadData];
    }else{
        [Commonality showErrorMsg:self type:fm.result msg:nil];
    }
}


-(void)show{
    _hihel=YES;
    _nodataView.hidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[userDefaults objectForKey:@"buyRecord"];
    if (dic!=nil) {
        [self paysingBuyInfo:dic Result:1];
    }
    
    
    if (_isVipType == YES) {
        [HttpRequest BuyVipListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    else
    {
        [HttpRequest BuyListRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    
    
//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                         _myView.alpha = 0;
//                     }];
//    
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
    
    
}


-(void)dismiss{
    [HttpRequest myCancelAsi];
    [UIView animateWithDuration:0.5
                     animations:^{
                        

                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];

                     }];
    

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
    return str1;
}


@end



