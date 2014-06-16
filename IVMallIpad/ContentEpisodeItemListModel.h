//
//  ContentEpisodeItemListModel.h
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentEpisodeItemListModel : NSObject
@property(nonatomic,assign)int pages;
@property(nonatomic,assign)int result;
@property(nonatomic,strong)NSString* errorMessage;
@property(nonatomic,strong)NSString* contentGuid;       //	内容ID
@property(nonatomic,strong)NSString* contentTitle;      //	内容名称
@property(nonatomic,assign)int playCount;
@property(nonatomic,assign)int favoriteCount;
@property(nonatomic,assign)int isCollect;
@property(nonatomic,strong)NSString* lang;
@property(nonatomic,assign)int counts;

@property(nonatomic,strong)NSString* contentGuid1;
@property(nonatomic,strong)NSString* contentTitle1;
@property(nonatomic,strong)NSString* contentDescription;
@property(nonatomic,strong)NSString* contentImg;
@property(nonatomic,assign)int playCount1;
@property(nonatomic,assign)int favoriteCount1;
@property(nonatomic,assign)int episodeCount;
@property(nonatomic,assign)int episodeLast;
@property(nonatomic,assign)int isCollect1;

@property(nonatomic,assign)BOOL oldPlay;

- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray*)mList page:(int)page;
@end
