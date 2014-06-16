//
//  JYTextField.m
//  meetingManager
//
//  Created by kinglate on 13-1-22.
//  Copyright (c) 2013年 joyame. All rights reserved.
//

#import "JYTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "Macro.h"
#import "Commonality.h"
#import "SKInnerShadowLayer.h"

@implementation JYTextField

- (id)initWithFrame:(CGRect)frame
		cornerRadio:(CGFloat)radio
		borderColor:(UIColor*)bColor
		borderWidth:(CGFloat)bWidth
		 lightColor:(UIColor*)lColor
		  lightSize:(CGFloat)lSize
   lightBorderColor:(UIColor*)lbColor
{
    self = [super initWithFrame:frame];
    if (self) {
        _borderColor = bColor;
		_cornerRadio = radio;
		_borderWidth = bWidth;
		_lightColor = lColor;
		_lightSize = lSize;
		_lightBorderColor = lbColor;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextChange:) name:UITextFieldTextDidChangeNotification object:self];
//        self.layer.borderWidth = 1;
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOpacity = 0.5;
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
//		[self.layer setCornerRadius:_cornerRadio];
//		[self.layer setBorderColor:_borderColor.CGColor];
//		[self.layer setBorderWidth:_borderWidth];
        _cornerRadio = 10;
        [self.layer setCornerRadius:25.5];
		[self.layer setBorderColor:[UIColor clearColor].CGColor];
		[self.layer setBorderWidth:0];

        
		[self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setBackgroundColor:[UIColor whiteColor]];
        self.alpha = 1;
		[self.layer setMasksToBounds:NO];
        
        
        SKInnerShadowLayer *animatedInnerShadowlayer = [[SKInnerShadowLayer alloc] init];
        
//        animatedInnerShadowlayer.colors = (@[ (id)[UIColor colorWithWhite:0.98f alpha:1.0f].CGColor,
//                                              (id)[UIColor colorWithWhite:0.9f alpha:1.0f].CGColor]);
//        
//        animatedInnerShadowlayer.backgroundColor = [UIColor clearColor].CGColor;
        animatedInnerShadowlayer.frame = CGRectMake(1, 1, frame.size.width - 2 , frame.size.height - 2);
        animatedInnerShadowlayer.cornerRadius = 25.5;
		
        animatedInnerShadowlayer.innerShadowOpacity = 1.0f;
        animatedInnerShadowlayer.innerShadowColor = [UIColor lightGrayColor].CGColor;
        animatedInnerShadowlayer.innerShadowOffset = CGSizeMake(2.0f, 2.0f);
        
        
        [self.layer addSublayer:animatedInnerShadowlayer];
    }
    return self;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
-(void)handleTextChange:(NSNotification*)notification
{
    
}
-(void)beginEditing:(NSNotification*)notification
{
	[self.layer setBorderColor:color_6.CGColor];
    [self.layer setBorderWidth:3];
}

-(void)endEditing:(NSNotification*)notification
{
    [self.layer setBorderWidth:0];
	[self.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _cornerRadio*2,
							  bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _cornerRadio*2,
							  bounds.size.height);
    return inset;
}
@end
