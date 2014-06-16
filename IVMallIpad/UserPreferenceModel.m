//
//  UserPreferenceModel.m
//  IVMallHD
//
//  Created by  周传森 on 14-4-23.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "UserPreferenceModel.h"

@implementation UserPreferenceModel
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init])
    {
        NSLog(@"json=%@",dictionary);
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        if (_result == 0) {
            NSDictionary* data = [dictionary objectForKey:@"data"];
            _preferenceKey = [data objectForKey:@"preferenceKey"];
            _preferenceValue = [data objectForKey:@"preferenceValue"];
        }
    }else{
        _result=-1;
    }
    return self;
}
@end
