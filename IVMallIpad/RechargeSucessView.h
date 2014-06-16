//
//  RechargeSucessView.h
//  IVMallHD
//
//  Created by Monster on 14-5-29.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock)(UIButton *button);

@interface RechargeSucessView : UIView
{
    UIImageView* bg;
    UIButton* backButton;
    UIButton* onceMoreButton;
    UILabel* sucussLabel;
    UILabel* balanceLabel;
    
    ButtonBlock _buttonBlock;
    UIView* _myView;
    
}
@property(nonatomic, assign)BOOL isPop;
@property(nonatomic, assign)BOOL isMain;
- (id)initWithFrame:(CGRect)frame isPop:(BOOL)isPop isMain:(BOOL)isMain;

- (void)setButtonBlock:(ButtonBlock)block;
- (void)setBalanceText:(NSString*)balance;

- (void)show;
@end
