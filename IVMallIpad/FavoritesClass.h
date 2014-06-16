//
//  FavoritesClass.h
//  IVMall (Ipad)
//
//  Created by sean on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface FavoritesClass : NSObject<ASIHTTPRequestDelegate>

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

-(void)psotRequest:(NSString*)str  delegate:(id)delegate;

@end
