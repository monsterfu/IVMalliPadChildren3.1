//
//  UserLoginModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "UserLoginModel.h"
#import "AppDelegate.h"

@implementation UserLoginModel
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init])
    {
        NSLog(@"json=%@",dictionary);
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        if (_result==0) {
            NSDictionary* data=[dictionary objectForKey:@"data"];
            if (data) {
                [AppDelegate App].personModel.tokenid = [[data objectForKey:@"token"]copy];
                [AppDelegate App].personModel.vipExpiryTime = [[data objectForKey:@"vipExpiryTime"]copy];
                NSString* temp = [data objectForKey:@"vipExpiryTip"];
                if (temp && [temp isEqualToString:@"true"]) {
                    [AppDelegate App].personModel.vipExpiryTip = YES;
                }else {
                    [AppDelegate App].personModel.vipExpiryTip = NO;
                }
            }
        }else{
            _errorMessage = [dictionary objectForKey:@"errorMessage"];
        }
    }else{
        _result=-1;
    }
    return self;
}
@end
