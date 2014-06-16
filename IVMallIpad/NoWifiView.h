//
//  NoWifiView.h
//  IVMall (Ipad)
//
//  Created by sean on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoWifiViewDelegate;

@interface NoWifiView : UIView

@property(nonatomic,assign)id<NoWifiViewDelegate>delegate;

-(void) show;

-(void) dismiss;


@end


@protocol NoWifiViewDelegate <NSObject>

-(void)callBackClickrech;

@end