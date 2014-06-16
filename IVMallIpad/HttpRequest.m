//
//  HttpRequest.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "HttpRequest.h"
#import "Macro.h"
#import "AppDelegate.h"
@implementation HttpRequest
+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSLog(@"url is %@",url);
    NSLog(@"%@ ---------%d",postdata,tag);
    NSURL *httpurl = [NSURL URLWithString:url];
    
    ASIHTTPRequest* asiRequest = [ASIHTTPRequest requestWithURL:httpurl];
    
    [asiRequest setTag:tag];
    [asiRequest appendPostData:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    [asiRequest setUseSessionPersistence:YES];
    [asiRequest setUseCookiePersistence:YES];
    [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [asiRequest setDelegate:delegate];
    
    [asiRequest setDidFinishSelector:finishSel];
    [asiRequest setDidFailSelector:failSel];
    
    [asiRequest startAsynchronous];
    
}

+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSLog(@"url is %@",url);
    NSLog(@"%@ ---------%d",postdata,tag);
//    NSURL *httpurl = [NSURL URLWithString:url];
    
//    request = [ASIHTTPRequest requestWithURL:httpurl];
    
    [request setTag:tag];
    [request appendPostData:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    [request setUseSessionPersistence:YES];
    [request setUseCookiePersistence:YES];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:delegate];
    
    [request setDidFinishSelector:finishSel];
    [request setDidFailSelector:failSel];
    
    [request startAsynchronous];
    
}

+(void)myCancelAsi
{
    
}

+(void)LoginRequest:(NSString*)mobile password:(NSString*)password delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    [self Request:LOGINURL postdate:[NSString stringWithFormat:@"{\"mobile\":\"%@\",\"password\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"deviceDRMId\":\"%@\",\"client\":\"ios\"}",mobile,password,IVMALL_VERSION,[AppDelegate.App.deviceInfoDic objectForKey:@"deviceDRMId"]] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)RegistRequest:(NSString *)mobile password:(NSString *)password promoCode:(NSString*)promoCode checkcode:(NSString *)checkcode delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:REGISTURL postdate:[NSString stringWithFormat:@"{\"mobile\":\"%@\",\"password\":\"%@\",\"promoCode\":\"%@\",\"validateCode\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"deviceDRMId\":\"%@\",\"client\":\"ios\",\"publishId\":\"ivmall\"}",mobile,password,promoCode,checkcode,IVMALL_VERSION,[AppDelegate.App.deviceInfoDic objectForKey:@"deviceDRMId"]] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)CheckCodeRequest:(NSString*)mobile delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:SMSCHECKURL postdate:[NSString stringWithFormat:@"{\"mobile\":\"%@\",\"appVersion\":\"%@\"}",mobile,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)BingdingToken:(NSString*)token delegate:(id)delegate deviceDRMID:(NSString*)devDRMID DRMType:(NSString*)drmType seral:(NSString*)serial macAddr:(NSString*)macAddr appVersion:(NSString*)appVersion osVersion:(NSString*)osVersion deviceInfo:(NSString*)deviceInfo inishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BINDING postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"deviceDRMId\":\"%@\",\"DRMType\":\"%@\",\"serial\":\"%@\",\"macAddr\":\"%@\",\"appVersion\":\"%@\",\"osVersion\":\"%@\",\"deviceInfo\":\"%@\",\"promoter\":\"ivmall\"}",token,devDRMID,drmType,serial,macAddr,IVMALL_VERSION,osVersion,deviceInfo] tag:BINDING_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)CannelEquipmentRequest:(NSString*)token deviceDRMId:(NSString*)deviceDRMId DRMType:(NSString*)DRMType delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CANNELEQUMENTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"deviceDRMId\":\"%@\",\"DRMType\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,deviceDRMId,DRMType,IVMALL_VERSION] tag:CANNELEQUMENTURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)logOutRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:LOGOUTURLNEW postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:LOGOUTURLNEW_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)BalanceRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BALANCEURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:BALANCEURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)BuyListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BUYLISTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"appVersion\":\"%@\",\"promoter\":\"ivmall\"}",token,page,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)FavoriteRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:LISTFOVIREURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"appVersion\":\"%@\",\"promoter\":\"ivmall\",\"rows\":\"15\"}",token,page,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)amendUserRequest:(NSString*)token  newPassword:(NSString*)newPass wornPassword:(NSString*)wornPass delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:MODIFYPSWURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"oldPassword\":\"%@\",\"newPassword\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,wornPass,newPass,IVMALL_VERSION] tag:MODIFYPSWURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)UserInfoRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:USERINFOURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:USERINFOURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)UpdatePersonInfoRequest:(NSString*)token nickname:(NSString*)nickname email:(NSString*)email lang:(NSString*)lang birthYear:(NSString*)birthYear gender:(NSString*)sex address:(NSString*)address delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:UPDATEUSERURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"nickname\":\"%@\",\"email\":\"%@\",\"lang\":\"%@\",\"birthday\":\"%@\",\"gender\":\"%@\",\"address\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,nickname,email,lang,birthYear,sex,address,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)forGetPassWordRequestPhone:(NSString*)phone validateCode:(NSString*)code passwode:(NSString*)pass delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:FORGETPASSWORD postdate:[NSString stringWithFormat:@"{\"mobile\":\"%@\",\"validateCode\":\"%@\",\"password\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",phone,code,pass,IVMALL_VERSION] tag:FORGETPASSWORD_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)indexAdRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel {
    [self Request:INDEXALLAD postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"client\":\"ios\"}",token,IVMALL_VERSION] tag:INDEXALLAD_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)catAllRequest:(NSString *)token channelCode:(NSString *)code page:(int)page type:(int)count delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CATALLLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"page\":\"%i\",\"rows\":\"%i\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,page,count,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)VideoAllRequest:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CATALLLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"index\":\"%i\",\"offset\":\"%i\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,index,offset,IVMALL_VERSION] tag:index delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)VideoAllRequest2:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
//    [self Request:CATALLLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"index\":\"%i\",\"offset\":\"%i\",\"categoryId\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,index,offset,ctaID,IVMALL_VERSION] tag:index delegate:delegate finishSel:finishSel failSel:failSel];
    [self Request:CATALLLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"index\":\"%i\",\"offset\":\"%i\",\"categoryId\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,index,offset,ctaID,IVMALL_VERSION] tag:index request:request delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)VideoAllRequest2:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CATALLLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"index\":\"%i\",\"offset\":\"%i\",\"categoryId\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,index,offset,ctaID,IVMALL_VERSION] tag:index delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)addFavorRequest:(NSString*)token  contentGiud:(NSString*)fiud delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:ADDFAVORITE postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"contentGuid\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,fiud,IVMALL_VERSION] tag:ADDFAVORITE_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)caelFavorWithConteng:(NSString*)token contentGiud:(NSString*)fiud delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CANFAVORITE postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"contentGuid\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,fiud,IVMALL_VERSION] tag:CANFAVORITE_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)SimpleRequest:(NSString*)token pid:(NSString*)pid type:(int)type delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:DELFOVIREURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"id\":\"%@\",\"promoter\":\"ivmall\"}",token,pid] tag:type delegate:delegate finishSel:finishSel failSel:failSel];
    
}

+(void)delAllFavoriteRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:DELFALLFAVORITE postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:DELFALLFAVORITE_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
    
}


+(void)PlayUrlRequest:(NSString*)token pid:(NSString*)pid protocol:(NSString*)protocol deviceDRMId:(NSString*)deviceDRMId DRMType:(NSString*)DRMType deviceGroup:(NSString*)deviceGroup contentGuid:(NSString*)contentGuid startTime:(NSString*)startTime endTime:(NSString*)endTime lang:(NSString*)lang delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString * myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
    if (myCharge && [myCharge isEqualToString:@"true"]) {
        [self Request:PLAYEVEDIO postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"protocol\":\"%@\",\"deviceDRMId\":\"%@\",\"DRMType\":\"%@\",\"deviceGroup\":\"%@\",\"contentGuid\":\"%@\",\"startTime\":\"%@\",\"endTime\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"lang\":\"%@\"}",token,protocol, deviceDRMId, DRMType, deviceGroup, contentGuid, startTime,endTime,IVMALL_VERSION,lang] tag:PLAYEVEDIO_type delegate:delegate finishSel:finishSel failSel:failSel];
    }
    else
    {
        [self Request:PLAYEVEDIO postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"protocol\":\"%@\",\"deviceDRMId\":\"%@\",\"DRMType\":\"%@\",\"deviceGroup\":\"%@\",\"contentGuid\":\"%@\",\"startTime\":\"%@\",\"endTime\":\"%@\",\"promoter\":\"ivmall\",\"client\":\"%@\",\"appVersion\":\"%@\",\"lang\":\"%@\"}",token,protocol, deviceDRMId, DRMType, deviceGroup, contentGuid, startTime,endTime,@"ios",IVMALL_VERSION,lang] tag:PLAYEVEDIO_type delegate:delegate finishSel:finishSel failSel:failSel];
    }
    
    
}

+(void)eplistRequest:(NSString*)token contengGuid:(NSString*)guid lang:(NSString*)lang page:(int)pag rows:(int)rows delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
       [self Request:EPISODELIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"contentGuid\":\"%@\",\"rows\":\"%i\",\"page\":\"%i\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"lang\":\"%@\"}",token,guid,rows,pag,IVMALL_VERSION,lang] tag:EPISODELIST_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)BuyVipListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BUYLISTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"appVersion\":\"%@\",\"promoter\":\"ivmall\",\"buyType\":\"vip\"}",token,page,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)PayRequest:(NSString*)token points:(NSString*)points fee:(NSString *)fee password:(NSString *)password delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:PAYURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"points\":\"%@\",\"voucherCode\":\"%@\",\"password\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,fee,points,password,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)PayListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:PAYLISTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,page,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)categoryRequestChannelCode:(NSString*)channelcode pag:(int)pag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:CATEGORY postdate:[NSString stringWithFormat:@"{\"channelCode\":\"%@\",\"appVersion\":\"%@\",\"page\":\"%i\",\"rows\":\"40\"}",channelcode,IVMALL_VERSION,pag] tag:CATEGORY_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)InfoRequest:(NSString*)token pid:(NSString*)pid page:(int) page categoryId:(NSString*)categoryId delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:DETAILURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"rows\":\"12\",\"appVersion\":\"%@\",\"promoter\":\"ivmall\",\"page\":\"%d\",\"categoryId\":\"%@\"}",token,pid,IVMALL_VERSION,page,categoryId] tag:DETAILURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}


+(void)evenTentRequestToken:(NSString*)token channelCode:(NSString*)code roundNumber:(int)round delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    if (round==0) {
        [self Request:EVENTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"roundNumber\":\"\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,IVMALL_VERSION] tag:EVENTURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
        return;
    }
    [self Request:EVENTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"channelCode\":\"%@\",\"roundNumber\":\"%i\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,code,round,IVMALL_VERSION] tag:EVENTURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)liveEPGRequest:(NSString*)token contentGuid:(NSString*)guid delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
     [self Request:LIVEEPGURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"contentGuid\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,guid,IVMALL_VERSION] tag:LIVEEPGURL_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)vipListRequest: (NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:VIPLISTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,page,IVMALL_VERSION] tag:VIPLIST_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)BuyVipRequest:(NSString*)token vipGuid:(NSString*)vipID points:(NSString*)points delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BUYVIP postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"vipGuid\":\"%@\",\"points\":\"%@\",\"appVersion\":\"%@\"}",token,vipID,points,IVMALL_VERSION] tag:BUYVIP_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
+(void)productListRequest:(NSString*)token contentGuid:(NSString *)contentGuid delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:ALLPRODUCTLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"contentGuid\":\"%@\",\"page\":\"%d\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,contentGuid,page,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)proInfoRequest:(NSString*)token contentGuid:(NSString *)contentGuid delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:PRODUCTINFO postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"productGuid\":\"%@\",\"page\":\"%d\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,contentGuid,page,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)playListRequest:(NSString*)token delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:PLAYLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"page\":\"%d\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"rows\":\"20\"}",token,page,IVMALL_VERSION] tag:page delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)delPlayHistoryRequest:(NSString *)token pid:(NSString *)pid delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:DELPLAY postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"id\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,pid,IVMALL_VERSION] tag:DELPLAY_TYPE   delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)delAllPlaylistRequest:(NSString *)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:DELALLPLAY postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:DELALLPLAY_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)BuyProduct:(NSString*)token pid:(NSString*)pid delegate:(id)delegate1 PassWord:(NSString*)pass deviceDRMId:(NSString*)device DRMType:(NSString*)type finishSel:(SEL)finishSel failSel:(SEL)failSel{
    [self Request:BUYURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"productGuid\":\"%@\",\"password\":\"%@\",\"deviceDRMId\":\"%@\",\"DRMType\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,pid,pass,device,type,IVMALL_VERSION] tag:BUY_TYPE delegate:delegate1 finishSel:finishSel failSel:failSel];
}

+(void)IndexFeaturedHomeRequestToken:(NSString*)token deviceDRMId:(NSString*)deviceDRMId delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    if(token == nil){
        [self Request:INDEXFEATUREDHOMEURL postdate:[NSString stringWithFormat:@"{\"deviceDRMId\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\"}",deviceDRMId,PROMOTER,IVMALL_VERSION] tag:INDEXFEATUREDHOME_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
    }else{
        [self Request:INDEXFEATUREDHOMEURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"deviceDRMId\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\"}",token,deviceDRMId,PROMOTER,IVMALL_VERSION] tag:INDEXFEATUREDHOME_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
    }
}

+(void)playTimeRequestToken:(NSString*)token delegate:delegate finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:PLAYTIME postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)pointsRequestToken:(NSString*)token delegate:delegate finishSel:(SEL)finishSel failSel:(SEL)failSel
{
    [self Request:POINTS postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\"}",token,IVMALL_VERSION] tag:POINTS_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)AlipayPrepareSecurePayRequestToken:(NSString*)token price:(double)price delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    [self Request:ALIPAYPREPARESECUREPAYURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"client\":\"%@\",\"price\":\"%f\",\"promoter\":\"%@\",\"appVersion\":\"%@\"}",token,@"ios",price,PROMOTER,IVMALL_VERSION] tag:ALIPAYPREPARESECUREPAY_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)AlipayTradeResultRequestToken:(NSString*)token outTradeNo:(NSString*) outTradeNo price:(double)price delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    [self Request:ALIPAYTRADERESULTURL postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"client\":\"%@\",\"totalFee\":\"%f\",\"outTradeNo\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\"}",token,@"ios",price,outTradeNo,PROMOTER,IVMALL_VERSION] tag:ALIPAYTRADERESULT_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)appInstallTimesRequestDeviceDRMId:(NSString*)deviceDRMId delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    [self Request:APPINSTALLTIMES postdate:[NSString stringWithFormat:@"{\"deviceDRMId\":\"%@\",\"client\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\"}",deviceDRMId,@"ios",PROMOTER,IVMALL_VERSION] tag:APPINSTALLTIMES_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)UserPreferenceRequestRoken:(NSString*)token preferenceKey:(NSString*)preferenceKey preferenceValue:(NSString*)preferenceValue delegate:(id)delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    if ([Commonality isEmpty:preferenceValue]) {
        [self Request:USERPREFERRNCE postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"client\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\",\"preferenceKey\":\"%@\"}",token,@"ios",PROMOTER,IVMALL_VERSION,preferenceKey] tag:USERPREFERRNCE_GET_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
    }
    else
    {
        [self Request:USERPREFERRNCE postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"client\":\"%@\",\"promoter\":\"%@\",\"appVersion\":\"%@\",\"preferenceKey\":\"%@\",\"preferenceValue\":\"%@\"}",token,@"ios",PROMOTER,IVMALL_VERSION,preferenceKey,preferenceValue] tag:USERPREFERRNCE_SET_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
    }
}

+(void)adRequestToken:(NSString*)token channelCode:(NSString*)channelCode delegate:(id)delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel
{
    [self Request:ADLIST postdate:[NSString stringWithFormat:@"{\"token\":\"%@\",\"promoter\":\"ivmall\",\"appVersion\":\"%@\",\"channelCode\":\"%@\"}",token,IVMALL_VERSION,channelCode] tag:ADLIST_TYPE delegate:delegate finishSel:finishSel failSel:failSel];
}
@end









