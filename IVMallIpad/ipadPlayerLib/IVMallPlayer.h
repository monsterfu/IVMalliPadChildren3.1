//
//  IVMallPlayer.h
//  IVMallForiPad
//
//  Created by simonz on 14-2-25.
//  Copyright (c) 2014年 SmitJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IVMallPlayerViewController;

enum{
    iPadPlayerWillPlaybackEnded = 0,
    iPadPlayerUserExited = 1,
    iPadPlayerPlaybackError = 2,
    iPadPlayerWillReturnFromCurrentPlay = 3,
    iPadPlayerWillReturnFromDMRPlay = 4,
};
typedef NSInteger iPadPlayerCallBackEventType;

@protocol iPadPlayerCallBackDelegate <NSObject>
-(void)iPadPlayerCallBack:(iPadPlayerCallBackEventType)callBackEventType withParameter: (NSMutableDictionary *)callBackInfo;
@end

@interface IVMallPlayer : NSObject
@property (weak, nonatomic)id<iPadPlayerCallBackDelegate> delegate;
@property (strong, nonatomic)IVMallPlayerViewController* lastIVMallPlayerViewController;


//创建单例
+ (IVMallPlayer *)sharedIVMallPlayer;

//初始化
- (NSInteger)IVMallPlayerInit:(NSString *)DRMServer :(NSString *)reportServer;

//播放
- (NSInteger)IVMallPlayerStart:(NSString *)url withVideoName:(NSString *)videoName fromViewController:(UIViewController *)viewController startTime:(NSTimeInterval)time;

//获取设备信息
- (NSMutableDictionary*)IVMallPlayerGetLocalInfo;

-(void)backToDMCControlFromViewController:(UIViewController*)viewController;
//销毁
- (void)IVMallPlayerDestroy;
@end
