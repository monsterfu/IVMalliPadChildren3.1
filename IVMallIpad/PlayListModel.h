//
//  PlayListModel.h
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayListModel : NSObject//播放记录列表

@property(nonatomic,assign)int result;
@property(nonatomic,strong)NSString* errorMessage;
@property(nonatomic,strong)NSString* playID;
@property(nonatomic,strong)NSString* contentGuid;       //	内容ID
@property(nonatomic,strong)NSString* contentTitle;      //	内容名称
@property(nonatomic,strong)NSString* contentImg;        //	内容图片
@property(nonatomic,strong)NSString* createTime;        //	添加时间	
@property(nonatomic,strong)NSString* dueTime;           //  过期时间
@property(nonatomic,assign)int duration;               //  已播放时间，暂时没用到
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)NSString* contentType;
- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray*)mList page:(int)page;
@end
