//
//  Macro.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//



#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ?YES:NO)

#define FAIILURE @"当前网络不可用，请检查网络！"
#define LINGKERROR @"网络连接异常，请重试!"
#define NOWIFIERROR @"当前网络异常,请先退出应用配置网络"
#define IVMALL_VERSION @"3.1.2"
#define ALOPH 0.6
#define PROMOTER @"20000"

//#define BASE @"http://221.228.203.230:28080"
//#define BASE @"http://192.168.20.130:28080"
#define BASE @"http://api.ivmall.com"
//#define NSLog(...) {}

#define LOGINURL [BASE stringByAppendingString:@"/user/login.action"]//登陆链接
#define REGISTURL [BASE stringByAppendingString:@"/user/register.action"]//注册
#define SMSCHECKURL [BASE stringByAppendingString:@"/user/sms.action"]//短信验证码
#define LOGOUTURLNEW [BASE stringByAppendingString:@"/user/logout.action"]//退出
#define USERINFOURL [BASE stringByAppendingString:@"/user/detail.action"]//用户详情
#define UPDATEUSERURL [BASE stringByAppendingString:@"/user/update.action"]//更新用户信息
#define BALANCEURL [BASE stringByAppendingString:@"/user/balance.action"]//用户余额
#define CHECKMOBILEURL [BASE stringByAppendingString:@"/user/mobile.action"]//校验手机号码
#define BINDING [BASE stringByAppendingString:@"/devices/bind.action"]//设备绑定
#define CANNELEQUMENTURL [BASE stringByAppendingString:@"/devices/unbind.action"]//设备解除绑定
#define BUYURL [BASE stringByAppendingString:@"/buy/add.action"]//购买
#define BUYLISTURL [BASE stringByAppendingString:@"/buy/list.action"]//购买记录
#define LISTFOVIREURL [BASE stringByAppendingString:@"/favorite/list.action"]//收藏夹列表
#define MODIFYPSWURL [BASE stringByAppendingString:@"/user/updatePassword.action"]//修改密码
#define FORGETPASSWORD [BASE stringByAppendingString:@"/user/forgetPassword.action"]//忘记密码


#define INDEXALLAD [BASE stringByAppendingString:@"/index/catHome.action"]//5.2.5	首页初始化

#define CATALLLIST [BASE stringByAppendingString:@"/channel/catContentList.action"]//5.3.7	频道猫全部内容列表
#define ADDFAVORITE [BASE stringByAppendingString:@"/favorite/add.action"]//添加收藏
#define CANFAVORITE [BASE stringByAppendingString:@"/favorite/delByGuid.action"]//根据内容取消收藏

#define DELFOVIREURL [BASE stringByAppendingString:@"/favorite/del.action"]//删除收藏将
#define DELFALLFAVORITE [BASE stringByAppendingString:@"/favorite/empty.action"]//清空收藏

#define PLAYEVEDIO [BASE stringByAppendingString:@"/product/play.action"]//播发URL

#define EPISODELIST [BASE stringByAppendingString:@"/content/episodeItemList.action"]//剧集内容列表

#define PAYURL [BASE stringByAppendingString:@"/pay/add.action"]//充值
#define PAYLISTURL [BASE stringByAppendingString:@"/pay/list.action"]//充值记录 
#define CATEGORY [BASE stringByAppendingString:@"/channel/categoryList.action"] //播放轮次  和分类
#define DETAILURL [BASE stringByAppendingString:@"/channel/contentList.action"]//产品详情


#define EVENTURL [BASE stringByAppendingString:@"/content/eventMatch.action"]//比赛列表(

#define LIVEEPGURL [BASE stringByAppendingString:@"/content/liveEpg.action"]//LIVE列表(

#define VIPLISTURL [BASE stringByAppendingString:@"/vip/list.action"]//vip列表
#define BUYVIP [BASE stringByAppendingString:@"/buy/vip.action"]  //购买VIP资格

#define ALLPRODUCTLIST [BASE stringByAppendingString:@"/content/productList.action"]
#define PRODUCTINFO [BASE stringByAppendingString:@"/product/detail.action"]

#define PLAYLIST [BASE stringByAppendingString:@"/play/list.action"]//最近播放
#define DELPLAY [BASE stringByAppendingString:@"/play/del.action"]//删除播放记录
#define DELALLPLAY [BASE stringByAppendingString:@"/play/empty.action"]//删除所有播放记录
#define CONFIG [BASE stringByAppendingString:@"/app/config.action"]//xiugai 1版本控制
#define INDEXFEATUREDHOMEURL [BASE stringByAppendingString:@"/index/featuredHome.action"]//5.2.7	首页初始化-mobile(v2.4)
#define APP_URL @"http://itunes.apple.com/lookup?id=848827713"//版本检测
#define PLAYTIME [BASE stringByAppendingString:@"/user/playTime.action"]//观看时长
#define POINTS [BASE stringByAppendingString:@"/app/points.action"]//点数列表
#define ALIPAYPREPARESECUREPAYURL [BASE stringByAppendingString:@"/alipay/prepareSecurePay.action"]//5.10.2.1	手机移动快捷支付
#define ALIPAYTRADERESULTURL [BASE stringByAppendingString:@"/alipay/tradeResult.action"]//5.10.3	交易状态查询
#define APPINSTALLTIMES [BASE stringByAppendingString:@"/app/install.action"]//首次安装应用
#define USERPREFERRNCE [BASE stringByAppendingString:@"/user/preference.action"]//断点续播
#define ADLIST [BASE stringByAppendingString:@"/channel/adList.action"]//首页广告位

#define LOGINURL_TYPE 10000
#define REGISTURL_TYPE 10001
#define LOGOUTURLNEW_TYPE 10002
#define SMSCHECKURL_TYPE 10003
#define USERINFOURL_TYPE 10004
#define UPDATEUSERURL_TYPE 10005
#define BALANCEURL_TYPE 10006
#define CHECKMOBILEURL_TYPE 10007
#define BINDING_TYPE 10008
#define CANNELEQUMENTURL_TYPE 10009
#define MODIFYPSWURL_TYPE 10010
#define FORGETPASSWORD_TYPE 10011
#define INDEXALLAD_TYPE 10012
#define CATALLLIST_TYPE 10013
#define ADDFAVORITE_TYPE 10014
#define CANFAVORITE_TYPE 10015
#define DELF_TYPE 10016
#define DELFALLFAVORITE_TYPE 10017
#define PLAYEVEDIO_type 10018
#define EPISODELIST_TYPE 10019 
#define CATEGORY_TYPE 10020
#define DETAILURL_TYPE 10021
#define EVENTURL_TYPE 10022
#define LIVEEPGURL_TYPE 10023
#define BUYVIP_TYPE 10024
#define PLAYLIST_TYPE 10025
#define DELPLAY_TYPE 10026
#define DELALLPLAY_TYPE 10027
#define CONFIG_TYPE 10028
#define VIPLIST_TYPE 10029
#define BUY_TYPE 10030
#define INDEXFEATUREDHOME_TYPE 10031
#define CHECKVERSION_TYPE 10032
#define POINTS_TYPE 10033
#define ALIPAYPREPARESECUREPAY_TYPE 10034
#define ALIPAYTRADERESULT_TYPE 10035
#define APPINSTALLTIMES_TYPE 10036
#define USERPREFERRNCE_SET_TYPE 10037
#define USERPREFERRNCE_GET_TYPE 10038
#define ADLIST_TYPE 10039

#define MANETIONCOLOL @"f0464e"
#define DISCOLOL @"519ea4"

#define CHECK_RETURN_CELL(a,b) do{if (!(a)) {NSLog(@"%s第%u行越界！",__FILE__,__LINE__); return b;};}while(0)
#define CHECK_NONERETURN(a) do{if (!(a)) {NSLog(@"%s第%u行越界！",__FILE__,__LINE__); return;};}while(0)


#define HEADVIEW_TITLESIZE 20
#define HEADVIEW_TITLE_ALPHA 0.8
#define HEADVIEW_BACKGROUND_COLOR @"323232"
#define LINEVIEW_COLOR @"c2c2c2"
#define INDICATOR_COLOR @"c3c3c3"

#define color_1 [Commonality colorFromHexRGB:@"1ea2cc"];
#define color_2 [Commonality colorFromHexRGB:@"058cb9"]
#define color_3 [Commonality colorFromHexRGB:@"1e9bc2"]
#define color_4 [Commonality colorFromHexRGB:@"ff5b5b"]
#define color_5 [Commonality colorFromHexRGB:@"e1b126"]
#define color_6 [Commonality colorFromHexRGB:@"09aae6"]
#define color_7 [Commonality colorFromHexRGB:@"79bb4c"]
#define color_8 [Commonality colorFromHexRGB:@"e490ab"]
#define color_9 [Commonality colorFromHexRGB:@"d26582"]
#define color_10 [Commonality colorFromHexRGB:@"05a6c2"]
#define color_11 [Commonality colorFromHexRGB:@"eac1a5"]
#define color_12 [Commonality colorFromHexRGB:@"3dbbdd"]
#define color_13 [Commonality colorFromHexRGB:@"f0f0f0"]
#define color_14 [Commonality colorFromHexRGB:@"ffffff"]
#define color_15 [Commonality colorFromHexRGB:@"000000"]
#define color_16 [Commonality colorFromHexRGB:@"ef3463"]
#define color_17 [Commonality colorFromHexRGB:@"a2bfca"]
#define color_18 [Commonality colorFromHexRGB:@"d2e9ef"]
#define color_19 [Commonality colorFromHexRGB:@"f0f6f8"]
#define color_20 [Commonality colorFromHexRGB:@"7eb9cc"]
#define color_21 [Commonality colorFromHexRGB:@"f1f9fb"]
#define color_22 [Commonality colorFromHexRGB:@"f0f5f8"]

#define font_1 [UIFont boldSystemFontOfSize:10]
#define font_2 [UIFont boldSystemFontOfSize:12]
#define font_3 [UIFont boldSystemFontOfSize:13]
#define font_4 [UIFont boldSystemFontOfSize:14]
#define font_5 [UIFont boldSystemFontOfSize:15]
#define font_6 [UIFont boldSystemFontOfSize:17]
#define font_7 [UIFont boldSystemFontOfSize:20]
#define font_8 [UIFont boldSystemFontOfSize:22]
#define font_9 [UIFont boldSystemFontOfSize:28]

#define alpha_1 0.2
#define alpha_2 0.3
#define alpha_3 0.6
#define alpha_4 0.8


#define NSNotificationCenter_CollectChanged     @"NSNotificationCenter_CollectChanged"