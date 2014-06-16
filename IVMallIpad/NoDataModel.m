//
//  NoDataModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "NoDataModel.h"

@implementation NoDataModel
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init])
    {
     
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        _errorMessage = [dictionary objectForKey:@"errorMessage"];
    }else{
        _result=-1;
    }
    return self;
}
@end
