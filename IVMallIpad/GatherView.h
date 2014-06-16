//
//  GatherView.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ChannelCatContentListModel.h"
#import "ContentEpisodeItemListModel.h"
#import "NoWifiView.h"
#import "IVMallPlayer.h"

enum{
    showFromMain = 0,
    showFromChildren = 1,
    showFromFavourite = 2,
};
typedef NSInteger gatherViewShowType;

@protocol changeFavouriteState <NSObject>

-(void)changeFavouriteCount:(UIButton*)sender;

@end

@protocol GatherViewDelegate;

@interface GatherView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,iPadPlayerCallBackDelegate>{
    CGRect rect;
    UIView*towBackView;
    UIImageView*imgView;
    UILabel*titleLabel;
    UILabel*playCountLabel;
    UILabel*favCountLabel;
    UILabel*orlabe;
    UIView*view1;
    UIView*view2;
    CGPoint backCent;
    UIActivityIndicatorView*activit;
    NoWifiView*nowWifi;
    NSString * productID;
    NSString * lang;
    NSString * selfContentGuid;
    UIButton*playeButton;
    int loadedPage;
    int totalPage;
    BOOL _isGetResult;
    BOOL _isPlayEndBack;
    int _lastPlayTime;
    int currentPlayingIndex;
    BOOL _isPlayVied;
    UILabel * lastPlayTimeLab;
    int _currentSelectedProgramTime;
    BOOL _isUserPerfernceResult;
    UIAlertView * _alert;
    BOOL _isShowingAlert;
    UIButton*backButton;
    gatherViewShowType _showFrom;
    UIImageView * backgroundImgView;
    UIImageView * indicatorImage;
    
}

@property(nonatomic,strong)UIView*backLianView1;
@property(nonatomic,strong)UIView*backLianView2;
@property(nonatomic,strong)UIView*backLianView3;
@property(nonatomic,strong)NSMutableArray * currentArr;
@property(nonatomic,assign)id<GatherViewDelegate>delegate;

@property(nonatomic,strong)ChannelCatContentListModel*myCatcontent;
@property(nonatomic,strong)ContentEpisodeItemListModel*myEpisode;

@property(nonatomic,strong)UITableView*tabelView;
@property(nonatomic,strong)NSMutableArray*tableArray;
@property(nonatomic,strong)UIScrollView*myScrollView;
@property(nonatomic,assign)BOOL hihel;
@property(nonatomic,strong)UIButton*favButton;

@property(nonatomic,strong)NSString* tmpName;

@property(nonatomic,assign)int myPage;
@property(nonatomic,assign)int statiPage;
@property(nonatomic,strong) ASIHTTPRequest * myRequest;
@property(nonatomic,strong)UIView*towBackView;

@property(nonatomic,strong)ASIHTTPRequest * addFavouriteRequest;
@property(nonatomic,strong)ASIHTTPRequest * delFavouriteRequest;
@property(nonatomic,strong)ASIHTTPRequest * playRequest;
@property(nonatomic,strong)UILabel*decLabel;

@property(nonatomic,strong)UIButton*playBut;
@property(nonatomic,assign) int isDelegate;
@property(nonatomic,assign)id<changeFavouriteState>delegate1;

@property(nonatomic,assign)BOOL isMain;
@property(nonatomic,strong)NSString * favContEntGuid;

-(id) initMy:(id)className;

-(void) show:(id)class2;
-(void)showFormFav:(NSString*)contEntGuid;
-(void)showFormMain:(NSString*)contEntGuid;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void) clickPlay:(UIButton*)sender;
@end


@protocol GatherViewDelegate <NSObject>

-(void)callbackPlay:(NSString*)url name:(NSString*)nsme;
-(void)changeFavouriteState;

@end
