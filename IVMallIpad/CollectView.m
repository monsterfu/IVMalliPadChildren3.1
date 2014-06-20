////
////  CollectView.m
////  IVMall (Ipad)
////
////  Created by sean on 14-2-25.
////  Copyright (c) 2014年 HYQ. All rights reserved.
////
//


//
//  CollectView.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-25.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "CollectView.h"
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
#import "ChildrenViewController.h"
#import "MainViewController.h"
#import "UserPreferenceModel.h"
@implementation CollectView

-(id) initMyWithFrame:(CGRect )newRect{
    if (self=[super init]) {
        
        self.pageNum=1;
        _isShowing = NO;
        _tableArray=[[NSMutableArray alloc]init];
        rect=[[UIScreen mainScreen] bounds];
        

        
        self.frame = newRect;
        self.backgroundColor=color_21;
        
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
        
        
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(50, 50, newRect.size.width-100, newRect.size.height - 50-100)];
        _tabelView.backgroundColor=[UIColor clearColor];
        _tabelView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tabelView.dataSource=self;
        _tabelView.delegate=self;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tabelView setTableFooterView:view];
        
        
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
        
//        lineView = [[UIView alloc] initWithFrame:CGRectMake(199.5, rect.size.width-44-[AppDelegate App].countIOS7-40, 1, 40)];
//        lineView.backgroundColor = [UIColor blackColor];
//        lineView.hidden = YES;
//        lineView.alpha = 0.6;
        
        
        
        _header = [MJRefreshHeaderView header];
        _header.scrollView = self.tabelView;
        _header.delegate = self;
        _header.headerDelegate = self;
        
        _footer = [MJRefreshFooterView footer];
        _footer.scrollView = self.tabelView;
        // 进入上拉加载状态就会调用这个方法
        
         __block CollectView * selfview = self;
        _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            NSLog(@"beginRefreshingBlock");
            selfview.editButton.userInteractionEnabled = NO;
            if ([Commonality isEmpty:[AppDelegate App].personModel.tokenid]) {
                [selfview reloadDeals];
                [Commonality showErrorMsg:selfview type:104 msg:nil];
            }else{
                if (selfview.tableArray.count==0) {
                    [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }else{
                    [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:selfview.pageNum+1 delegate:selfview finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                }
            }
        };
        
        
        [self addSubview:_tabelView];
        [self addSubview:delSingelView];
        [self addSubview:delAllView];
        [self addSubview:lineView];
        tmpRect=self.frame;
    }
    
    [_tabelView registerNib:[UINib nibWithNibName:@"Favourite_normalCell" bundle:nil] forCellReuseIdentifier:@"NormalCell"];
    [_tabelView registerNib:[UINib nibWithNibName:@"Favourite_EdittingCell" bundle:nil] forCellReuseIdentifier:@"EdittingCell"];
    
    _nodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, newRect.size.width, 350)];
    _nodataView.backgroundColor = [UIColor clearColor];
    [_tabelView addSubview:_nodataView];
    _nodataView.hidden = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(newRect.size.height/2 - 150, 0, 200, 200)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"收藏.png"];
    [_nodataView addSubview:imageView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(-55, 220, _nodataView.frame.size.width, 30)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"当前没有收藏视频";
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.alpha = 0.48;
    lab.font = [UIFont boldSystemFontOfSize:23];
    [_nodataView addSubview:lab];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tips)];
    tap1.numberOfTapsRequired = 3;
    [self addGestureRecognizer:tap1];
    
    selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, newRect.size.width-80, 61)];
    selectedBackView.backgroundColor = color_18;
    return self;
}


-(void)dismissALLView
{
    [Commonality dismissAllView];
}


-(void)del:(UIButton *) button
{
    if (button == _delSingleBtn) {
        NSMutableString *ms = [[NSMutableString alloc] init];
        for (int i = 0; i < _tableArray.count; i++) {
            FavoriteListModel * fm = [_tableArray objectAtIndex:i];
            
            if (fm.isSelect) {
                [ms appendString:fm.favID];
                [ms appendString:@","];
            }
        }
        NSMutableString * str = [[NSMutableString alloc] init];
        if (ms.length == 0) {
            return;
        }
        CHECK_NONERETURN(ms.length > ms.length - 1);
        [str appendString:[ms substringToIndex:ms.length - 1]];
        
//        [Commonality showErrorMsg:self type:0 msg:@"正在取消收藏......"];
        [HttpRequest SimpleRequest:AppDelegate.App.personModel.tokenid pid:str type:DELF_TYPE delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"是否要清空?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
        alert.tag = 500;
        [alert show];
        [_tabelView reloadData];
    }
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (alertView.tag == 501) {
            [self performSelector:@selector(showMyProgramPackageView) withObject:nil afterDelay:1];
        }
        else
        {
            [HttpRequest delAllFavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
    }
}

-(void)showMyProgramPackageView
{
    
//    -(void)clickTableViewIndex:(int)index;
//    -(void)showProgramView;
    
    if (_showProgramDelegate && [_showProgramDelegate respondsToSelector:@selector(showProgramView)]) {
        [_showProgramDelegate showProgramViewWithProID:productID];
    }
    
//    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
//    pro.productId = productID;
//    pro.isShowFromMain = NO;
//    [pro show];
}

- (IBAction)edit:(id)sender {
    self.isEdit=!self.isEdit;
    if(self.isEdit){
        lineView.hidden = NO;
        _delAllBtn.hidden = NO;
        _delSingleBtn.hidden = NO;
        _header.scrollView = nil;
        _header.hidden = YES;
        _delSingleBtn.imageView.alpha = 0.3;
        _delSingleBtn.userInteractionEnabled = NO;
        
        [self.backButton setHidden:YES];
        [_selectArray removeAllObjects];
        
//        _editButton.frame=CGRectMake(30, 9, 30, 30);
//        _editButton.frame=CGRectMake(30 , 10, 90, 40);
        [_editButton setImage:[UIImage imageNamed:@"取消.png"] forState:UIControlStateNormal];
        [_editButton setTitle:@"取消" forState:UIControlStateNormal];
        [_delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
        _editButton.frame=CGRectMake(30 , 10, 90, 40);
        
    }else{
        lineView.hidden = YES;
        _delAllBtn.hidden = YES;
        _delSingleBtn.hidden = YES;
        [_delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [AppDelegate.App.selectedDic removeAllObjects];
        for (int i = 0; i < _tableArray.count; i++) {
            FavoriteListModel * fm = [_tableArray objectAtIndex:i];
            fm.isSelect = NO;
        }
        
        
        _header.scrollView = _tabelView;
        _header.hidden = NO;
        [_selectArray removeAllObjects];
        
        [self.backButton setHidden:NO];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
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
        [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

-(void)refreshViewShouldBeginRefreshing
{
    _editButton.userInteractionEnabled = NO;
}


-(void)releaseTableView
{
    _tabelView.userInteractionEnabled = YES;
}

#pragma mark -
#pragma mark UITableView Datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (!_isEdit) {
            
            Favourite_NormalCell * cell = (Favourite_NormalCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            if ([Commonality isEnableWIFI]==0) {
                [self reloadDeals];
                [Commonality showErrorMsg:self type:0 msg:FAIILURE];
                return;
            }
            
            if (indexPath.row > [_tableArray count]-1) {
                return;
            }
            FavoriteListModel* fm=[_tableArray objectAtIndex:indexPath.row];
            self.tmpName = fm.contentTitle;
            
            if ([fm.isEpisode intValue] == 1) {
                
                if ([productID isEqualToString:fm.contentGuid]) {
                    if (_gat.isDelegate == YES) {
                        return;
                    }
                }
                
                if (_gat) {
                    [_gat dismiss];
                    _gat = nil;
                }
                _gat = [[GatherView alloc] initMy:nil];
                
                [AppDelegate App].selctImgCent=CGPointMake(cell.contentView.frame.origin.x+3, cell.contentView.frame.origin.y+120);
                
                ChildrenViewController * children;
                    CustomTabBarCtl * root= (CustomTabBarCtl*)self.window.rootViewController;
                    children = [root.viewControllers objectAtIndex:1];
                self.tabelView.userInteractionEnabled = NO;
                [self performSelector:@selector(releaseTableView) withObject:nil afterDelay:1];
                productID = fm.contentGuid;
                _gat.delegate = children;
//                [_gat showFormFav:fm.contentGuid];
                if (_showGatherDelegate && [_showGatherDelegate respondsToSelector:@selector(showGatherView:)]) {
                    [_showGatherDelegate showGatherView:fm.contentGuid];
                }
            }
            else
            {
                self.contentType = fm.contentType;
                productID = fm.contentGuid;
                self.tabelView.userInteractionEnabled = NO;
                
//                if ([fm.contentType isEqualToString:@"contentType"]) {
//                    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//                    return;
//                }
//                else
//                {
                    [HttpRequest PlayUrlRequest:AppDelegate.App.personModel.tokenid pid:fm.contentGuid protocol:@"hls0" deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:@"loco" deviceGroup:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceGroup"] contentGuid:fm.contentGuid startTime:@"" endTime:@"" lang:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//                }
            }
        }else{
            Favourite_EdittingCell* cell = (Favourite_EdittingCell*)[tableView cellForRowAtIndexPath:indexPath];
            [cell del:cell.delBtn];
            
        }
//     [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    FavoriteListModel * fm = [_tableArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier1 = @"NormalCell";
    static NSString *cellIdentifier2 = @"EdittingCell";
    if (!_isEdit) {
        Favourite_NormalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[Favourite_NormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.exclusiveTouch = YES;
        }
        cell.titleLabel.text = fm.contentTitle;
        cell.colletTimeLabel.text = [self setTime:fm.collectTime];
//        cell.contentView.backgroundColor = color_18;
        if ([fm.contentType isEqualToString:@"vod"]) {
            cell.typeImage.image = [UIImage imageNamed:@"4.png"];
        }
        else
        {
            cell.typeImage.image = [UIImage imageNamed:@"4-1.png"];
        }
        cell.contentView.backgroundColor = color_21;
        cell.selectedBackgroundView = selectedBackView;
        return cell;
    }
    else
    {
        Favourite_EdittingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[Favourite_EdittingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.exclusiveTouch = YES;
        }
        cell.titleLabel.text = fm.contentTitle;
        cell.collectTimeLabel.text = [self setTime:fm.collectTime];
        cell.delBtn.tag = indexPath.row;
        
        NSString * isSel = [AppDelegate.App.selectedDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]] ;
        if ([isSel isEqualToString:@"1"]) {
            fm.isSelect = YES;
            [cell.delBtn setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
        }
        else
        {
            fm.isSelect = NO;
            [cell.delBtn setImage:[UIImage imageNamed:@"raido_sel.png"] forState:UIControlStateNormal];
        }
        if ([fm.contentType isEqualToString:@"vod"]) {
            cell.typeImage.image = [UIImage imageNamed:@"4.png"];
        }
        else
        {
            cell.typeImage.image = [UIImage imageNamed:@"4-1.png"];
        }
        cell.contentView.backgroundColor = color_21;
        cell.selectedBackgroundView = selectedBackView;
        return cell;
    }
}

-(void)tips
{
    return;
}

-(void)reloadContentView
{
    switch ([AppDelegate App].tabBarController.viewCtlNum) {
        case 0:
        {
            MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
            [mainViewCtl markHomeRequest];
        }
            break;
            
        default:
        {
            ChildrenViewController * childrenViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:[AppDelegate App].tabBarController.viewCtlNum];
            [childrenViewCtl viewWillAppear:YES];
        }
            break;
    }
}

#pragma mark 刷新
- (void)reloadDeals{
    [_header endRefreshing];
    [_footer endRefreshing];
}

-(void) GetErr:(ASIHTTPRequest *)request{
    self.tabelView.userInteractionEnabled = YES;
    self.editButton.userInteractionEnabled = YES;
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
    [self reloadDeals];
    self.isEdit = NO;
    [AppDelegate.App.selectedDic removeAllObjects];
    for (int i = 0; i < _tableArray.count; i++) {
        FavoriteListModel * fm = [_tableArray objectAtIndex:i];
        fm.isSelect = NO;
    }
    [_tabelView reloadData];
    [self normalState];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    [self reloadDeals];
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        
    }else{
        if (request.tag == DELF_TYPE) {
            NoDataModel * model = [[NoDataModel alloc] initWithDictionary:dictionary];
            if (model.result == 0) {
//               [Commonality showErrorMsg:self type:0 msg:@"取消收藏成功!"];
                [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:nil];
                for (int i = 0; i < _tableArray.count; i++) {
                    FavoriteListModel * fm = [_tableArray objectAtIndex:i];
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
                    FavoriteListModel * fm = [_tableArray objectAtIndex:i];
                    fm.isSelect = NO;
                }
                [self normalState];
                
                
//                MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
//                [mainViewCtl markHomeRequest];
                [self reloadContentView];
                
                [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
            else
            {
                 [Commonality showErrorMsg:self type:0 msg:@"网络连接异常！"];
            }
        }
        else if (request.tag == DELFALLFAVORITE_TYPE)
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
                
                
//                MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
//                [mainViewCtl markHomeRequest];
                [self reloadContentView];
                [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_CollectChanged object:nil];
            }
            else
            {
                [MKInfoPanel showPanelInView:self title:@"网络连接异常！" isMiddleShow:NO];
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
                if (str.length < 1) {
                    if ([self.contentType isEqualToString:@"event"]) {
                        [Commonality showErrorMsg:self type:0 msg:@"未开赛"];
                        return;
                    }
                }
                _playUrl = str;
                
                
                [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:nil delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                
                
                
//                [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:str withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:0];
//                self.hidden = YES;
//                self.myView.hidden = YES;
//                AppDelegate.App.userView.hidden = YES;
//                AppDelegate.App.userView.myView.hidden = YES;
                self.isPlayHidend = YES;
                
            }else{
                self.tabelView.userInteractionEnabled = YES;
                if (url.result==204) {
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
            self.tabelView.userInteractionEnabled = YES;
            int starTime;
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
                
                [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerStart:_playUrl withVideoName:self.tmpName fromViewController:[AppDelegate App].tabBarController startTime:starTime];
                
            }
            else
            {
                [Commonality showErrorMsg:self type:userPreferModel.result msg:LINGKERROR];
            }
        }
        
        else
        {
            [self pasingFavoriteInfo:dictionary cont:request.tag];
        }
    }
}



-(void)pasingFavoriteInfo:(NSDictionary*)dictionary cont:(int)count{
    
    //    FavoriteModel* fm=[[FavoriteModel alloc]initWithDictionary:dictionary modelList:_tableArray page:count];
    FavoriteListModel * fm =[[FavoriteListModel alloc]initWithDictionary:dictionary modelList:_tableArray page:count];
    if (_tableArray.count == 0) {
        _nodataView.hidden = NO;
        _editButton.hidden = YES;
    }
    else
    {
        _nodataView.hidden = YES;
        _editButton.hidden = NO;
    }
    
    //    if (count==1) {
    //        if ([self.selectArray count]!=0) {
    //            for (int i=0; i<[self.selectArray count]; i++) {
    //                FavoriteModel*favorit=[self.selectArray objectAtIndex:i];
    //                for (int j=0; j<[_favoriteList count]; j++) {
    //                    FavoriteModel*favorit2=[_favoriteList objectAtIndex:j];
    //                    if ([favorit.favID isEqualToString:favorit2.favID]) {
    //                        favorit2.isSelect=YES;
    //                        [self.selectArray replaceObjectAtIndex:i withObject:favorit2];
    //
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    if (fm.result==0) {
        if (count==1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dictionary forKey:@"FavoriteInfo"];
            [userDefaults synchronize];
        }
        
        self.pageNum=count;
        
        if (_tableArray.count==0) {
            //            imgView.hidden = NO;
            //            mesageLabel.hidden = NO;
            _editButton.hidden = YES;
        }else{
            //            imgView.hidden = YES;
            //            mesageLabel.hidden = YES;
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
    lineView.hidden = YES;
    [_selectArray removeAllObjects];
    
    [self.backButton setHidden:NO];
    
    [_editButton setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
    _editButton.frame=CGRectMake(self.frame.size.width - 130 , 10, 90, 40);
    self.isEdit = NO;
    [_tabelView reloadData];
}

-(void)fresh
{
    [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
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
    
    
    [self normalState];
    _editButton.userInteractionEnabled = YES;
    _hihel=YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[userDefaults objectForKey:@"FavoriteInfo"];
    if (dic!=nil) {
        [self pasingFavoriteInfo:dic cont:1];
    }
    [HttpRequest FavoriteRequest:[AppDelegate App].personModel.tokenid page:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];

//    UIViewController * main = [AppDelegate App].tabBarController;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                         _myView.alpha = 0;
//                     }];
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

    [AppDelegate.App.selectedDic removeAllObjects];
    for (int i = 0; i < _tableArray.count; i++) {
        FavoriteListModel * fm = [_tableArray objectAtIndex:i];
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
    return [NSString stringWithFormat:@"收藏时间:%@",str1];
}

-(void)iPadPlayerCallBack:(iPadPlayerCallBackEventType)callBackEventType withParameter:(NSMutableDictionary *)callBackInfo
{
    int time = [[callBackInfo objectForKey:@"time"] intValue];
    [HttpRequest UserPreferenceRequestRoken:[AppDelegate App].personModel.tokenid preferenceKey:[NSString stringWithFormat:@"play.position.%@",productID] preferenceValue:[NSString stringWithFormat:@"1.%d",time] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

@end


