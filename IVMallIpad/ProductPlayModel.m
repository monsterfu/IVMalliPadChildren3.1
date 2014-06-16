//
//  ProductPlayModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ProductPlayModel.h"

@implementation ProductPlayModel
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init])
    {
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        _errorMessage = [dictionary objectForKey:@"errorMessage"];
        if (_result == 0) {
             NSDictionary* data = [dictionary objectForKey:@"data"];
            _URI = [data objectForKey:@"URI"];
            _catchupURI = [data objectForKey:@"catchupURI"];
        }
    }else{
        _result=-1;
    }
    return self;
}
@end
