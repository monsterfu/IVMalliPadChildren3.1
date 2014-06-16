//
//  VipListView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-7.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "MJRefresh.h"

@interface VipListView : UIView<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate>
{
    CGRect rect;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    CGRect tmpRect;
}
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign)BOOL hihel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * tableArr;
@property (nonatomic, assign) int pageNum;
-(id) initMy;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;


@end
