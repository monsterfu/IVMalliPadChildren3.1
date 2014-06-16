//
//  PlayHistoryView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-13.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "PlayHistoryView.h"
#import "AppDelegate.h"
#import "FavoriteModel.h"
#import "FavoriteListModel.h"
#import "Favourite_NormalCell.h"
#import "Favourite_EdittingCell.h"
#import "UIButton+Bootstrap.h"
#import "MKInfoPanel.h"
#import "NoDataModel.h"
#import "NoDataModel.h"
#import "ProductPlayModel.h"
#import "PlayListModel.h"
#import "ProgramPackage.h"
#import "UserPreferenceModel.h"
@implementation PlayHistoryView
static int height = 0;
-(id) initMyWithFrame:(CGRect )newRect{
    if (self=[super init]) {
        
        
        
        self.pageNum=1;
        _isShowing = NO;
        starTime = 0;
        _tableArray=[[NSMutableArray alloc]init];
        rect=[[UIScreen mainScreen] bounds];
        
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
        self.frame = newRect;
//        self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
        self.backgroundColor=color_21;
        
//        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 50)];
//        heatView.backgroundColor=[UIColor clearColor];
        
//        _backButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//        [_backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
//        _backButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//        [_backButton addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//        _backButton.backgroundColor=[UIColor clearColor];
//        _backButton.frame=CGRectMake(30, 10, 30, 30);
////        [heatView addSubview:_backButton];
//        
//        UILabel*titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 40)];
//        titleLabe.textColor=[UIColor whiteColor];
//        titleLabe.text=@"最近播放";
//        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
//        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
//        titleLabe.textAlignment=NSTextAlignmentCenter;
//        titleLabe.backgroundColor=[UIColor clearColor];
//        [heatView addSubview:titleLabe];
        
//        _editButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//
//        [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
//        
//        
//        _editButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//        _editButton.backgroundColor=[UIColor clearColor];
//        _editButton.frame=CGRectMake(340, 10, 30, 30);
//        [_editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
//        [heatView addSubview:_editButton];
        
        _editButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
        
        _editButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        _editButton.backgroundColor=color_20;
        _editButton.layer.cornerRadius = 20;
        _editButton.frame=CGRectMake(newRect.size.width - 100 , 10, 60, 51);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        //        insets = {top, left, bottom, right};
        _editButton.imageEdgeInsets = UIEdgeInsetsMake(4,10,4,50);
        _editButton.titleEdgeInsets = UIEdgeInsetsMake(7.5, -40, 5, 0);
        [_editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        //       UIView * ediBtnBackView = [Commonality makeButtonShadowViewWhitbtn:_editButton];
        //        [_editButton childrenBtnStyle];
        
        [self addSubview:_editButton];
        
        
        totalTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 400, height)];
        totalTimeLab.backgroundColor = [UIColor blackColor];
        totalTimeLab.alpha = 0.6;
        totalTimeLab.font = [UIFont boldSystemFontOfSize:15];
        totalTimeLab.textColor = [UIColor lightGrayColor];
        
        
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(50, 50 + height, newRect.size.width-100, rect.size.width-44-[AppDelegate App].countIOS7-50 - height - 100)];
        _tabelView.backgroundColor=[UIColor clearColor];
        _tabelView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tabelView.dataSource=self;
        _tabelView.delegate=self;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tabelView setTableFooterView:view];
//        _delSingleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _delSingleBtn.frame = CGRectMake(0, rect.size.width-44-[AppDelegate App].countIOS7-40, 199.5, 40);
//        [_delSingleBtn setImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
//        //         {top, left, bottom, right};
//        _delSingleBtn.imageEdgeInsets = UIEdgeInsetsMake(5,85,5,85);
//        [_delSingleBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
//        _delSingleBtn.backgroundColor = [Commonality colorFromHexRGB:@"2a2a2a"];
//        _delSingleBtn.hidden = YES;
//        
//        _delAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _delAllBtn.frame = CGRectMake(200.5, rect.size.width-44-[AppDelegate App].countIOS7-40, 199.5, 40);
//        [_delAllBtn setImage:[UIImage imageNamed:@"清空.png"] forState:UIControlStateNormal];
//        _delAllBtn.imageEdgeInsets = UIEdgeInsetsMake(5,85,5,85);
//        [_delAllBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
//        _delAllBtn.backgroundColor = [Commonality colorFromHexRGB:@"2a2a2a"];
//        _delAllBtn.hidden = YES;
        
        _delSingleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delSingleBtn.frame = CGRectMake(newRect.size.width - 320 , rect.size.width-44-[AppDelegate App].countIOS7-40 - 30, 120, 51);
        [_delSingleBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
        [_delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
        _delSingleBtn.backgroundColor = color_4;
        [_delSingleBtn childrenBtnStyleForBtn:_delSingleBtn];
        delSingelView = [Commonality makeButtonShadowViewWhitbtn:_delSingleBtn];
        _delSingleBtn.hidden = YES;
        
        _delAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delAllBtn.frame = CGRectMake(newRect.size.width - 170, rect.size.width-44-[AppDelegate App].countIOS7-40 - 30, 120, 51);
        [_delAllBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
        [_delAllBtn setTitle:@"清空" forState:UIControlStateNormal];
        _delAllBtn.backgroundColor = color_20;
        [_delAllBtn childrenBtnStyleForBtn:_delAllBtn];
        delAllView = [Commonality makeButtonShadowViewWhitbtn:_delAllBtn];
        _delAllBtn.hidden = YES;
        
        
        
        _header = [MJRefreshHeaderView header];
        _header.scrollView = self.tabelView;
        _header.delegate = self;
        _header.headerDelegate = self;
        
        _footer = [MJRefreshFooterView footer];
        _footer.scrollView = self.tabelView;
        // 进入上拉加载状态就会调用这个方法
        
        __block PlayHistoryView * selfview = self;
        _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            NSLog(@"beginRefreshingBlock");
            selfview.editButton.userInteractionEnabled = NO;
            if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
                [selfview reloadDeals];
                [Commonality showErrorMsg:selfview type:104 msg:nil];
            }else{
                if (selfview.tableArray.count==0) {
                    [HttpRequest playListRequest:[AppDelegate App].personModel.tokenid delegate:selfview page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }else{
                    [HttpRequest playListRequest:[AppDelegate App].personModel.tokenid delegate:selfview page:selfview.pageNum + 1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
            }
        };
        
        
//        [self addSubview:heatView];
        [self addSubview:_tabelView];
        [self addSubview:delSingelView];
        [self addSubview:delAllView];
        [self addSubview:totalTimeLab];
        tmpRect=self.frame;
    }
    
    [_tabelView registerNib:[UINib nibWithNibName:@"Favourite_normalCell" bundle:nil] forCellReuseIdentifier:@"NormalCell"];
    [_tabelView registerNib:[UINib nibWithNibName:@"Favourite_EdittingCell" bundle:nil] forCellReuseIdentifier:@"EdittingCell"];
    
    _nodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, newRect.size.width, 350)];
    _nodataView.backgroundColor = [UIColor clearColor];
    [_tabelView addSubview:_nodataView];
    _nodataView.hidden = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(newRect.size.height/2 - 170, 0, 200, 200)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"recording.png"];
    [_nodataView addSubview:imageView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(-80, 220, _nodataView.frame.size.width, 30)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"没有最近观看记录哦";
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.alpha = 0.48;
    lab.font = [UIFont boldSystemFontOfSize:23];
    [_nodataView addSubview:lab];
    [Commonality setImgViewStyle:self];
    
    selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 530, 61)];
    selectedBackView.backgroundColor = color_18;
    return self;
}



-(void)del:(UIButton *) button
{
    if (button == _delSingleBtn) {
        NSMutableString *ms = [[NSMutableString alloc] init];
        for (int i = 0; i < _tableArray.count; i++) {
            PlayListModel * fm = [_tableArray objectAtIndex:i];
            
            if (fm.isSelect) {
                [ms appendString:fm.playID];
                [ms appendString:@","];
            }
        }
        NSMutableString * str = [[NSMutableString alloc] init];
        if (ms.length == 0) {
            return;
        }
        CHECK_NONERETURN(ms.length > ms.length - 1);
        [str appendString:[ms substringToIndex:ms.length - 1]];
//        [Commonality showErrorMsg:self type:0 msg:@"正在删除记录..."];
       
        [HttpRequest delPlayHistoryRequest:AppDelegate.App.personModel.tokenid pid:str delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"是否要清空?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
        alert.tag = 500;
        [alert show];
        [_tabelView reloadData];
    }
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
//        [Commonality showErrorMsg:self type:0 msg:@"正在删除记录..."];
        if (alertView.tag == 500) {
            [HttpRequest delAllPlaylistRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        else if (alertView.tag == 501)
        {
            [self performSelector:@selector(showMyProgramPackageViewExt) withObject:nil afterDelay:1];
        }
        
    }
}

-(void)showMyProgramPackageView
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.productId = productID;
    [pro show];
}

-(void)showMyProgramPackageViewExt
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.productId = productID;
    pro.isShowFromMain = NO;
    [pro show];
}

- (IBAction)edit:(id)sender {
    self.isEdit=!self.isEdit;
    if(self.isEdit){
        _delAllBtn.hidden = NO;
        _delSingleBtn.hidden = NO;
        _header.scrollView = nil;
        _header.hidden = YES;
        
        [self.backButton setHidden:YES];
        [_selectArray removeAllObjects];
        _delSingleBtn.imageView.alpha = 0.3;
        _delSingleBtn.userInteractionEnabled = NO;
        [_editButton setImage:[UIImage imageNamed:@"取消.png"] forState:UIControlStateNormal];
        [_editButton setTitle:@"取消" forState:UIControlStateNormal];
        _editButton.frame=CGRectMake(30 , 10, 90, 40);
        [_delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
        
    }else{
        _delAllBtn.hidden = YES;
        _delSingleBtn.hidden = YES;
        [AppDelegate.App.selectedDic removeAllObjects];
        for (int i = 0; i < _tableArray.count; i++) {
            PlayListModel * fm = [_tableArray objectAtIndex:i];
            fm.isSelect = NO;
        }
        
        
        _header.scrollView = _tabelView;
        _header.hidden = NO;
        [_selectArray removeAllObjects];
        
        [self.backButton setHidden:NO];
        
        [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
//        _editButton.frame=CGRectMake(340, 10, 30, 30);
//        _tabelView.frame = CGRectMake(0, _tabelView.frame.origin.y, _tabelView.frame.size.width, rect.size.width-44-[AppDelegate App].countIOS7-50 -  height);
        _editButton.frame=CGRectMake(self.frame.size.width - 130 , 10, 90, 40);
    }
    
    [_tabelView reloadData];
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
        [_header performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
        [Commonality showErrorMsg:self type:104 msg:nil];
        return;
    }
    _editButton.userInteractionEnabled = NO;
    if (refreshView == _header) { // 下拉刷新
        [HttpRequest playListRequest:[AppDelegate App].personModel.tokenid delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

-(void)refreshViewShouldBeginRefreshing
{
    _editButton.userInteractionEnabled = NO;
}

#pragma mark -
#pragma mark UITableView Datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isEdit) {
        
        if (!_isEdit) {
            
            if ([Commonality isEnableWIFI]==0) {
                [self reloadDeals];
                [Commonality showErrorMsg:self type:0 msg:FAIILURE];
                return;
            }
            
            CHECK_NONERETURN(_tableArray.count > indexPath.row);
            
            PlayListModel* fm=[_tableArray objectAtIndex:indexPath.row];
            self.tmpName = fm.contentTitle;
            productID = fm.contentGuid;
            
            self.tabelView.userInteractionEnabled = NO;
            [HttpRequest PlayUrlRequest:AppDelegate.App.personModel.tokenid pid:fm.contentGuid protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:fm.contentGuid startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            
        }
        
    }else{
        Favourite_EdittingCell* cell = (Favourite_EdittingCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell del:cell.delBtn];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayListModel * fm = [_tableArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier1 = @"NormalCell";
    static NSString *cellIdentifier2 = @"EdittingCell";
    if (!_isEdit) {
        Favourite_NormalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[Favourite_NormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text = fm.contentTitle;
        cell.colletTimeLabel.text = [self setTime:fm.createTime];
        cell.contentView.backgroundColor = color_21;
//        if ([fm.contentType isEqualToString:@"event"]) {
//            cell.typeImage.image = [UIImage imageNamed:@"4.png"];
//        }
//        else
//        {
//        cell.typeImage.imageEdgeInsets = UIEdgeInsetsMake(12,12,12,12);
            cell.typeImage.image = [UIImage imageNamed:@"type_icon.png"];
//        }
        cell.selectedBackgroundView = selectedBackView;
        return cell;
    }
    
    else
    {
        Favourite_EdittingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[Favourite_EdittingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text = fm.contentTitle;
        cell.collectTimeLabel.text = [self setTime:fm.createTime];
        cell.delBtn.tag = indexPath.row + 20000;
        cell.contentView.backgroundColor = color_21;
        NSString * isSel = [AppDelegate.App.selectedDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 20000]] ;
        if ([isSel isEqualToString:@"1"]) {
            fm.isSelect = YES;
            [cell.delBtn setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
        }
        else
        {
            fm.isSelect = NO;
            [cell.delBtn setImage:[UIImage imageNamed:@"raido_sel.png"] forState:UIControlStateNormal];
        }
//        if ([fm.contentType isEqualToString:@"event"]) {
            cell.typeImage.image = [UIImage imageNamed:@"type_icon.png"];
//        }
//        else
//        {
//            cell.typeImage.image = [UIImage imageNamed:@"4-1.png"];
//        }
        cell.selectedBackgroundView = selectedBackView;
        return cell;
    }
}




#pragma mark 刷新
- (void)reloadDeals{
    [_header endRefreshing];
    [_footer endRefreshing];
}

-(void) GetErr:(ASIHTTPRequest *)request{
    self.tabelView.userInteractionEnabled = YES;
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
    [self reloadDeals];
    self.isEdit = NO;
    [AppDelegate.App.selectedDic removeAllObjects];
    for (int i = 0; i < _tableArray.count; i++) {
        PlayListModel * fm = [_tableArray objectAtIndex:i];
        fm.isSelect = NO;
    }
    [self normalState];
    [_tabelView reloadData];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    [self reloadDeals];
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        
    }else{
        if (request.tag == DELPLAY_TYPE) {
            
            
            NoDataModel * model = [[NoDataModel alloc] initWithDictionary:dictionary];
            if (model.result == 0) {
                
                for (int i = 0; i < _tableArray.count; i++) {
                    PlayListModel * fm = [_tableArray objectAtIndex:i];
                    if (fm.isSelect) {
                        [_tableArray removeObject:fm];
                    }
                }
                if (_tableArray.count == 0) {
                    _nodataView.hidden = NO;
                    _editButton.hidden = YES;
                }
                else
                {
                    _nodataView.hidden = YES;
                    _editButton.hidden = NO;
                }
                [AppDelegate.App.selectedDic removeAllObjects];
                for (int i = 0; i < _tableArray.count; i++) {
                    PlayListModel * fm = [_tableArray objectAtIndex:i];
                    fm.isSelect = NO;
                }
                [self normalState];
                [HttpRequest playListRequest:[AppDelegate App].personModel.tokenid delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
            else
            {
                [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
            }
        }
        else if (request.tag == DELALLPLAY_TYPE)
        {
            NoDataModel * model = [[NoDataModel alloc] initWithDictionary:dictionary];
            if (model.result == 0) {
                //                [MKInfoPanel showPanelInView:self title:@"取消收藏成功!" isMiddleShow:NO];
            
                [AppDelegate.App.selectedDic removeAllObjects];
                [_tableArray removeAllObjects];
                if (_tableArray.count == 0) {
                    _nodataView.hidden = NO;
                }
                else
                {
                    _nodataView.hidden = YES;
                }
                [self normalState];
                _editButton.hidden = YES;
            }
            else
            {
//                [MKInfoPanel showPanelInView:self title:@"网络连接异常！" isMiddleShow:NO];
                [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
            }
            
        }
        
        else if (request.tag==PLAYEVEDIO_type){
//            self.tabelView.userInteractionEnabled = YES;
            ProductPlayModel*url=[[ProductPlayModel alloc]initWithDictionary:dictionary];
            if (url.result==0) {
                NSString*str=nil;
                if (url.URI.length>1.0) {
                    str=url.URI;
                }else{
                    str=url.catchupURI;
                }
                _playUrl = str;
                
                [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                
                
//                [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:starTime];
//                self.hidden = YES;
//                self.myView.hidden = YES;
////                AppDelegate.App.userView.hidden = YES;
//                self.isPlayHidend = YES;
                
            }else{
                self.tabelView.userInteractionEnabled = YES;
                if (url.result == 204) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"会员权限未开通或已过期" message:@"请先开通会员！" delegate:self cancelButtonTitle:@"稍后开通" otherButtonTitles:@"立即开通", nil];
                    alert.tag = 501;
                    [alert show];
                    return;
                }
                
                [Commonality showErrorMsg:self type:url.result msg:@"网络连接异常，请重试"];
                
            }
        }
        else if (request.tag == USERPREFERRNCE_GET_TYPE)
        {
            NSLog(@"tag1 is %d",request.tag);
            self.tabelView.userInteractionEnabled = YES;
            UserPreferenceModel * userPreferModel = [[UserPreferenceModel alloc] initWithDictionary:dictionary];
            if (userPreferModel.result == 0) {
                if (![Commonality isEmpty:userPreferModel.preferenceValue]) {
                    NSArray * arr1 = [userPreferModel.preferenceValue componentsSeparatedByString:@"."];
                    if (arr1.count ==2) {
                        starTime = [[arr1 lastObject] intValue];
                    }
                    else
                    {
                        starTime = 0;
                    }
                }
                else
                {
                    starTime = 0;
                }
//                self.tabelView.userInteractionEnabled = NO;
                [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:_playUrl withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:starTime];
//                [HttpRequest PlayUrlRequest:AppDelegate.App.personModel.tokenid pid:productID protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:productID startTime:@"" endTime:@"" ipAddr:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
            else
            {
                [Commonality showErrorMsg:self type:userPreferModel.result msg:LINGKERROR];
            }

            
            
            
        }
        else if (request.tag == USERPREFERRNCE_SET_TYPE)
        {
            return;
        }
        
        else
        {
            [self pasingFavoriteInfo:dictionary cont:request.tag];
        }
    }
}

-(void)pasingFavoriteInfo:(NSDictionary*)dictionary cont:(int)count{
    PlayListModel * fm = [[PlayListModel alloc] initWithDictionary:dictionary modelList:_tableArray page:count];
    if (count == 1) {
        int playTime = [[[[dictionary objectForKey:@"data"] objectForKey:@"playTime"] objectForKey:@"total"] intValue];
        int hour = playTime/3600;
        int sec = playTime%3600;
        int min = sec/60;
        totalTimeLab.text = [NSString stringWithFormat:@"       您总共观看了%d小时%d分",hour,min];
//        if (hour == 0 && min == 0) {
//            totalTimeLab.text = [NSString stringWithFormat:@"       您总共观看了%d秒",sec];
//        }
        
    }
    if (_tableArray.count == 0) {
        _nodataView.hidden = NO;
        _editButton.hidden = YES;
    }
    else
    {
        _nodataView.hidden = YES;
        _editButton.hidden = NO;
    }
    
    if (fm.result==0) {
        if (count==1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dictionary forKey:@"PlayHistory"];
            [userDefaults synchronize];
        }
        
        self.pageNum=count;
        
        if (_tableArray.count==0) {
            _editButton.hidden = YES;

        }else{
            _editButton.hidden = NO;

        }
        
        [_tabelView reloadData];
        _editButton.userInteractionEnabled = YES;
    }else{
        [Commonality showErrorMsg:self type:fm.result msg:nil];
    }
    
}

-(void)normalState
{
    _header.scrollView = _tabelView;
    _header.hidden = NO;
    _delAllBtn.hidden = YES;
    _delSingleBtn.hidden = YES;
    _editButton.hidden = NO;
    [_selectArray removeAllObjects];
    
    [self.backButton setHidden:NO];
    
    [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
//    _editButton.frame=CGRectMake(340, 10, 30, 30);
//    _tabelView.frame = CGRectMake(0, _tabelView.frame.origin.y, _tabelView.frame.size.width, rect.size.width-44-[AppDelegate App].countIOS7-50- height);
    _editButton.frame=CGRectMake(self.frame.size.width - 130 , 10, 90, 40);
    self.isEdit = NO;
    [_tabelView reloadData];
}



-(void)show{
    
    if ([IVMallPlayer sharedIVMallPlayer].delegate) {
        [IVMallPlayer sharedIVMallPlayer].delegate = nil;
    }
    [IVMallPlayer sharedIVMallPlayer].delegate = self;
    
    
    [AppDelegate.App.selectedDic removeAllObjects];
    for (int i = 0; i < _tableArray.count; i++) {
        FavoriteListModel * fm = [_tableArray objectAtIndex:i];
        fm.isSelect = NO;
    }
    
    starTime = 0;
    _editButton.userInteractionEnabled = YES;
//    if (![AppDelegate App].isLogin) {
//        if ([AppDelegate App].userView==nil) {
//            [AppDelegate App].userView=[[UserView alloc]initMy];
//        }
//        [[AppDelegate App].userView show];
//        return;
//    }
    [self normalState];
    
    _hihel=YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[userDefaults objectForKey:@"PlayHistory"];
    if (dic!=nil) {
        [self pasingFavoriteInfo:dic cont:1];
    }
    [HttpRequest playListRequest:[AppDelegate App].personModel.tokenid delegate:self page:1 finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];

//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                         _myView.alpha = 0.5;
//                         _myView.frame = CGRectMake(main.view.frame.origin.x, main.view.frame.origin.y, main.view.frame.size.height, main.view.frame.size.width);
//                     }];
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
}

-(void)dismiss{
    [HttpRequest myCancelAsi];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0;
                     } completion:^(BOOL finished) {
                         _hihel=NO;
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                     }];
    [AppDelegate.App.selectedDic removeAllObjects];
    for (int i = 0; i < _tableArray.count; i++) {
        PlayListModel * fm = [_tableArray objectAtIndex:i];
        fm.isSelect = NO;
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
    return [NSString stringWithFormat:@"上次观看时间:%@",str1];
}

-(void)iPadPlayerCallBack:(iPadPlayerCallBackEventType)callBackEventType withParameter:(NSMutableDictionary *)callBackInfo
{
    int time = [[callBackInfo objectForKey:@"time"] intValue];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:[NSString stringWithFormat:@"1.%d",time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

@end
