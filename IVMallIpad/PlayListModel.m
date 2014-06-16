//
//  PlayListModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "PlayListModel.h"

@implementation PlayListModel
- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray *)mList page:(int)page{
    if (self = [super init])
    {
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        _errorMessage = [dictionary objectForKey:@"errorMessage"];
        if (_result==0) {
            NSArray *array = [NSArray arrayWithArray:[[dictionary objectForKey:@"data"]objectForKey:@"list"]];
            if(array){
                
                if (page==1) {
                    [mList removeAllObjects];
                }
                for (NSDictionary *childinfo in array) {
                    PlayListModel *um=[[PlayListModel alloc]initWithDictionaryEx:childinfo];
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
        _isSelect=NO;
        _playID = [dictionary objectForKey:@"id"];
        _contentGuid = [dictionary objectForKey:@"contentGuid"];
        _contentTitle = [dictionary objectForKey:@"contentTitle"];
        _contentImg = [dictionary objectForKey:@"contentImg"];
        _createTime = [dictionary objectForKey:@"createTime"];
        _dueTime = [dictionary objectForKey:@"dueTime"];
        _contentType = [dictionary objectForKey:@"contentType"];
//        _duration = [[[dictionary objectForKey:@"playTime"] objectForKey:@"total"] intValue];
        _result = 0;
    }else{
        _result = -1;
    }
    return self;
}
@end
