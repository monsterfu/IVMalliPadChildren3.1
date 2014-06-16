//
//  FavoritesClass.m
//  IVMall (Ipad)
//
//  Created by sean on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "FavoritesClass.h"
#import "HttpRequest.h"
#import "Commonality.h"
#import "AppDelegate.h"
@implementation FavoritesClass

-(void)psotRequest:(NSString*)str  delegate:(id)delegate{
    [HttpRequest addFavorRequest:[AppDelegate App].personModel.tokenid contentGiud:str delegate:delegate finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
}

-(void) GetErr:(ASIHTTPRequest *)request{
    
}

-(void) GetResult:(ASIHTTPRequest *)request{
    
}

@end
