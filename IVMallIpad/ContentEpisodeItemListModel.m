//
//  ContentEpisodeItemListModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ContentEpisodeItemListModel.h"

@implementation ContentEpisodeItemListModel
- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray *)mList page:(int)page{
    if (self = [super init])
    {
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        _errorMessage = [dictionary objectForKey:@"errorMessage"];
   
        if (_result==0) {
            NSArray *array = [NSArray arrayWithArray:[[dictionary objectForKey:@"data"]objectForKey:@"list"]];
            _pages=[[[dictionary objectForKey:@"data"]objectForKey:@"pages"]intValue];
            _counts=[[[dictionary objectForKey:@"data"]objectForKey:@"counts"]intValue];
            
            _contentGuid1=[[dictionary objectForKey:@"data"]objectForKey:@"episodeGuid"];
            _contentTitle1=[[dictionary objectForKey:@"data"]objectForKey:@"episodeTitle"];
            _contentDescription=[[dictionary objectForKey:@"data"]objectForKey:@"episodeDescription"];
            _contentImg=[[dictionary objectForKey:@"data"]objectForKey:@"episodeImg"];
            _episodeCount=[[[dictionary objectForKey:@"data"]objectForKey:@"episodeCount"]intValue];
            _episodeLast=[[[dictionary objectForKey:@"data"]objectForKey:@"episodeLast"]intValue];
            _isCollect1=[[[dictionary objectForKey:@"data"]objectForKey:@"isCollect"]intValue];
            _playCount1 =[[[dictionary objectForKey:@"data"]objectForKey:@"playCount"]intValue];
            _favoriteCount1 = [[[dictionary objectForKey:@"data"]objectForKey:@"favoriteCount"]intValue];
            if(array){
                if (page==1) {
                    [mList removeAllObjects];
                }
                for (NSDictionary *childinfo in array) {
                    ContentEpisodeItemListModel *um=[[ContentEpisodeItemListModel alloc]initWithDictionaryEx:childinfo];
                    [mList addObject:um];
                }
            }
        }
    }else{
        _result=-1;
    }
    return self;
}

- (id)initWithDictionaryEx:(NSDictionary *)dictionary{
    if (self = [super init]){
        _contentGuid = [dictionary objectForKey:@"contentGuid"];
        _contentTitle = [dictionary objectForKey:@"contentTitle"];
        _playCount = [[dictionary objectForKey:@"playCount"]intValue];
        _favoriteCount = [[dictionary objectForKey:@"favoriteCount"]intValue];
        _isCollect = [[dictionary objectForKey:@"isCollect"]intValue];
        _lang = [dictionary objectForKey:@"langs"];
        _result = 0;
        _oldPlay=NO;
    }else{
        _result = -1;
    }
    return self;
}
@end
