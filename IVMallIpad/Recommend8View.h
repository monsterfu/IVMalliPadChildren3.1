//
//  Recommend8View.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupGatherViewDelegate.h"
#import "ASIHTTPRequest.h"
#import "GatherView.h"
@interface Recommend8View : UIView<ASIHTTPRequestDelegate,changeFavouriteState>{
    BOOL duodian;
    
    GatherView*gatherView;
    
}

@property(nonatomic,assign)id<PopupGatherViewDelegate>delegate;

@property(nonatomic,strong)NSMutableArray*myArray;
@property(nonatomic,strong)UILabel*titleLabe;



- (id)initWithFrame:(CGRect)frame data:(NSMutableArray*)array;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void)changeFavouriteCount:(UIButton *)sender;
@end

