//
//  ProductInfoCell.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-12.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ProductInfoCell.h"
#import "AppDelegate.h"
#import "productInfoView.h"
#import "ProductInfoModel.h"
#import "HttpRequest.h"
#import "AppDelegate.h"

@implementation ProductInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favourite:(UIButton *)sender {
    productInfoView * proInfoView = nil;
    if ([AppDelegate App].isIOS7) {
        proInfoView = (productInfoView *) self.viewForBaselineLayout.superview.superview.superview;
        
    }else{
        proInfoView = (productInfoView *) self.viewForBaselineLayout.superview.superview;
        
    }
    
    ProductInfoModel * proInfoModel = [proInfoView.proInfoArr objectAtIndex:sender.tag];
    if (sender.imageView.image == [UIImage imageNamed:@"Collection3.png"]) {
        [HttpRequest addFavorRequest:AppDelegate.App.personModel.tokenid contentGiud:proInfoModel.productGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    else
    {
        [HttpRequest caelFavorWithConteng:AppDelegate.App.personModel.tokenid contentGiud:proInfoModel.productGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}


-(void) GetResult:(ASIHTTPRequest *)request{
    
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//    NSString*str=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
    }else{
        if (request.tag == ADDFAVORITE_TYPE) {
            if ([[dictionary objectForKey:@"errorCode"] intValue] == 0) {
                [_favouriteBtn setImage:[UIImage imageNamed:@"Collection2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"] intValue] msg:LINGKERROR];
            }
        }
        else
        {
            if ([[dictionary objectForKey:@"errorCode"] intValue] == 0) {
                [_favouriteBtn setImage:[UIImage imageNamed:@"Collection3.png"] forState:UIControlStateNormal];
            }
            else
            {
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"] intValue] msg:LINGKERROR];
            }
        }
    }
}

@end
