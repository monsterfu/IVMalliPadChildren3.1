//
//  HttpRequest.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface HttpRequest : NSObject

+(void)myCancelAsi;
+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)LoginRequest:(NSString*)mobile password:(NSString*)password delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)RegistRequest:(NSString*)mobile password:(NSString*)password promoCode:(NSString*)promoCode checkcode:(NSString*)checkcode delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)CheckCodeRequest:(NSString*)mobile delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)BingdingToken:(NSString*)token delegate:(id)delegate deviceDRMID:(NSString*)devDRMID DRMType:(NSString*)drmType seral:(NSString*)serial macAddr:(NSString*)macAddr appVersion:(NSString*)appVersion osVersion:(NSString*)osVersion deviceInfo:(NSString*)deviceInfo inishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)CannelEquipmentRequest:(NSString*)token deviceDRMId:(NSString*)deviceDRMId DRMType:(NSString*)DRMType delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)logOutRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)BalanceRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)BuyListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)FavoriteRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)amendUserRequest:(NSString*)token  newPassword:(NSString*)newPass wornPassword:(NSString*)wornPass delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)UserInfoRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)UpdatePersonInfoRequest:(NSString*)token nickname:(NSString*)nickname email:(NSString*)email lang:(NSString*)lang birthYear:(NSString*)birthYear gender:(NSString*)sex address:(NSString*)address delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)forGetPassWordRequestPhone:(NSString*)phone validateCode:(NSString*)code passwode:(NSString*)pass delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;



+(void)indexAdRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)catAllRequest:(NSString *)token channelCode:(NSString *)code page:(int)page type:(int)count delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)VideoAllRequest:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)VideoAllRequest2:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)VideoAllRequest2:(NSString *)token channelCode:(NSString *)code index:(int)index offset:(int)offset categoryId:(NSString*)ctaID delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;



+(void)addFavorRequest:(NSString*)token  contentGiud:(NSString*)fiud delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)caelFavorWithConteng:(NSString*)token contentGiud:(NSString*)fiud delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)SimpleRequest:(NSString*)token pid:(NSString*)pid type:(int)type delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)delAllFavoriteRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;


+(void)PlayUrlRequest:(NSString*)token pid:(NSString*)pid protocol:(NSString*)protocol deviceDRMId:(NSString*)deviceDRMId DRMType:(NSString*)DRMType deviceGroup:(NSString*)deviceGroup contentGuid:(NSString*)contentGuid startTime:(NSString*)startTime endTime:(NSString*)endTime lang:(NSString*)lang delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;


+(void)eplistRequest:(NSString*)token contengGuid:(NSString*)guid lang:(NSString*)lang page:(int)pag rows:(int)rows delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)BuyVipListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)PayRequest:(NSString*)token points:(NSString*)points fee:(NSString *)fee password:(NSString *)password delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)PayListRequest:(NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)categoryRequestChannelCode:(NSString*)channelcode pag:(int)pag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)InfoRequest:(NSString*)token pid:(NSString*)pid page:(int) page categoryId:(NSString*)categoryId delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;


+(void)evenTentRequestToken:(NSString*)token channelCode:(NSString*)code roundNumber:(int)round delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)liveEPGRequest:(NSString*)token contentGuid:(NSString*)guid delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)vipListRequest: (NSString*)token page:(int)page delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)BuyVipRequest:(NSString*)token vipGuid:(NSString*)vipID points:(NSString*)points delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)productListRequest:(NSString*)token contentGuid:(NSString *)contentGuid delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)proInfoRequest:(NSString*)token contentGuid:(NSString *)contentGuid delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)playListRequest:(NSString*)token delegate:(id)delegate page:(int)page finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)delPlayHistoryRequest:(NSString*)token pid:(NSString*)pid delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)delAllPlaylistRequest:(NSString*)token delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)BuyProduct:(NSString*)token pid:(NSString*)pid delegate:(id)delegate1 PassWord:(NSString*)pass deviceDRMId:(NSString*)device DRMType:(NSString*)type finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)IndexFeaturedHomeRequestToken:(NSString*)token deviceDRMId:(NSString*)deviceDRMId delegate:delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)playTimeRequestToken:(NSString*)token delegate:delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)pointsRequestToken:(NSString*)token delegate:delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)AlipayPrepareSecurePayRequestToken:(NSString*)token price:(double)price delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel;
+(void)AlipayTradeResultRequestToken:(NSString*)token outTradeNo:(NSString*) outTradeNo price:(double)price delegate:delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel;
+(void)appInstallTimesRequestDeviceDRMId:(NSString*)deviceDRMId delegate:(id)delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel;
+(void)UserPreferenceRequestRoken:(NSString*)token preferenceKey:(NSString*)preferenceKey preferenceValue:(NSString*)preferenceValue delegate:(id)delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel;
+(void)adRequestToken:(NSString*)token channelCode:(NSString*)channelCode delegate:(id)delegate finishSel:(SEL)finishSel  failSel:(SEL)failSel;
@end
























