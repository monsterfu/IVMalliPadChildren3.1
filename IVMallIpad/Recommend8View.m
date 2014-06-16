//
//  Recommend8View.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "Recommend8View.h"
#import "Commonality.h"
#import "UIImageView+WebCache.h"
#import "ChannelCatContentListModel.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "ChildrenViewController.h"

#define  LINE_MAXNUM   (5)

@implementation Recommend8View

- (id)initWithFrame:(CGRect)frame data:(NSMutableArray*)array{
    
//    for (int i = 0; i < array.count; i++) {
//        ChannelCatContentListModel*catModel=[array objectAtIndex:i];
//        if ([catModel.contentTitle rangeOfString:@"迪斯尼"].location != NSNotFound) {
//            [array removeObjectAtIndex:i];
//        }
//    }
    
    if (self=[super initWithFrame:frame]) {
        if ([array count]==0) {
            return self;
        }
        self.myArray=array;
        int iscon=0;
        int iscont2=0;
        if ([array count]<LINE_MAXNUM) {
            iscon=1;
        }else{
            iscon=2;
        }
        duodian=NO;
        
        for (int i=0; i<iscon; i++) {
            iscont2 = ([array count]-LINE_MAXNUM*i > LINE_MAXNUM)?(LINE_MAXNUM):([array count]-LINE_MAXNUM*i);
            
            for (int j=0; j<iscont2; j++) {
                ChannelCatContentListModel*catModel=[array objectAtIndex:LINE_MAXNUM*i+j];
                
                UIImageView*imgVIew=[[UIImageView alloc]initWithFrame:CGRectMake(48*(j+1)+(frame.size.width-282)/LINE_MAXNUM*j, frame.size.height/2*i + LINE_MAXNUM + i * 14, (frame.size.width-282)/LINE_MAXNUM, frame.size.height/2-60 - 24)];
                
//                NSLog(@"imgView.x is %f y is %f wide is %f height is %f",imgVIew.frame.origin.x,imgVIew.frame.origin.y,imgVIew.frame.size.width,imgVIew.frame.size.height);
                
                imgVIew.userInteractionEnabled=YES;
                
                imgVIew.contentMode = UIViewContentModeScaleToFill;
                imgVIew.clipsToBounds = YES;
                
                UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImgeView:)];
                tap.numberOfTapsRequired=1;
                [imgVIew addGestureRecognizer:tap];
                imgVIew.exclusiveTouch = YES;
                imgVIew.tag=LINE_MAXNUM*i+j+1000;
                NSString*str=catModel.contentImg;//[catModel.contentImg stringByReplacingOccurrencesOfString:@".jpg" withString:@"-s.jpg"];
     
                if ([catModel.contentType isEqualToString:@"live"]==NO) {
             
                    [imgVIew setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"videoBackground.png"]];
                  
                }else{
                  
                    [imgVIew setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"videoBackground.png"]];
               
                    UIButton*leftButon=[UIButton buttonWithType:(UIButtonTypeCustom)];
                    [leftButon setBackgroundImage:[UIImage imageNamed:@"programTable.png"] forState:(UIControlStateNormal)];
                    [leftButon addTarget:self action:@selector(showEPG:) forControlEvents:UIControlEventTouchUpInside];
                    leftButon.tag=imgVIew.tag;
                    leftButon.alpha=ALOPH;
                    leftButon.frame=CGRectMake(0, imgVIew.frame.size.height-34, 34, 34);
                    leftButon.exclusiveTouch = YES;
                    [imgVIew addSubview:leftButon];

                }
                
                UIImageView*imgVIew2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgVIew.frame.origin.x - 16, imgVIew.frame.origin.y + 3.5 , imgVIew.frame.size.width + 32, imgVIew.frame.size.height + 20)];
                imgVIew2.image = [UIImage imageNamed:@"CloudCoverage3.png"];
                
                _titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(26*(j+1)+(frame.size.width-182)/LINE_MAXNUM*j, frame.size.height/2*i+imgVIew.frame.size.height+5 + 6 + i * 14, (frame.size.width-182)/LINE_MAXNUM, 20)];
//                _titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(16,imgVIew2.frame.size.height - 20,(frame.size.width-182)/6,20)];
                _titleLabe.text=catModel.contentTitle;
                _titleLabe.textColor=color_2;
                _titleLabe.alpha=ALOPH;
                _titleLabe.font=font_4;
                _titleLabe.backgroundColor=[UIColor clearColor];
                [imgVIew2 addSubview:_titleLabe];
                
                UIImageView*plaIm=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Record1.png"]];
                plaIm.frame=CGRectMake(_titleLabe.frame.origin.x,  _titleLabe.frame.origin.y+_titleLabe.frame.size.height+5, 10, 10);
//                [self addSubview:plaIm];

            
                UIButton*favButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
                favButton.frame=CGRectMake(imgVIew.frame.size.width-34, imgVIew.frame.size.height-34 - 30, 34, 34);
                favButton.tag=imgVIew.tag;
                favButton.alpha=ALOPH;
                favButton.backgroundColor=[UIColor clearColor];
                [favButton addTarget:self action:@selector(clickFavButton:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([catModel.contentType isEqualToString:@"live"]) {
                    if (catModel.isCollect==0) {
                        [favButton setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
                    }else{
                        [favButton setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
                    }
                    UILabel*cureeLabe=[[UILabel alloc]initWithFrame:CGRectMake(plaIm.frame.origin.x+15, _titleLabe.frame.origin.y+20, _titleLabe.frame.size.width-15, 20)];
                    cureeLabe.backgroundColor=[UIColor clearColor];
                    cureeLabe.font=[UIFont systemFontOfSize:10];
                    cureeLabe.textColor=color_2;
                    cureeLabe.alpha=ALOPH;
                    cureeLabe.text=catModel.liveSubhead;
                    [self addSubview:cureeLabe];
                   
                }else{
                    if (catModel.isCollect==0) {
                        [favButton setBackgroundImage:[UIImage imageNamed:@"onLIveCollec.png"] forState:(UIControlStateNormal)];
                    }else{
                        [favButton setBackgroundImage:[UIImage imageNamed:@"onLIveCollec2.png"] forState:(UIControlStateNormal)];
                    }
                  
                    
                    UILabel*playCountLable=[[UILabel alloc]initWithFrame:CGRectMake(plaIm.frame.origin.x+plaIm.frame.size.width+5, _titleLabe.frame.origin.y+_titleLabe.frame.size.height, _titleLabe.frame.size.width/2-20, 20)];
                    playCountLable.text=[NSString stringWithFormat:@"%.0f",catModel.playCount];
                    playCountLable.font=[UIFont systemFontOfSize:10];
                    playCountLable.textColor=color_2;
                    playCountLable.alpha=ALOPH;
                    playCountLable.backgroundColor=[UIColor clearColor];
//                    [self addSubview:playCountLable];
                    
                    UIImageView*favIm=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Collection.png"]];
                    favIm.frame=CGRectMake(playCountLable.frame.size.width+playCountLable.frame.origin.x+10,  _titleLabe.frame.origin.y+_titleLabe.frame.size.height+5, 10, 10);
//                    [self addSubview:favIm];
                    
                    UILabel*faVOcuntLable=[[UILabel alloc]initWithFrame:CGRectMake(favIm.frame.size.width+favIm.frame.origin.x+5, playCountLable.frame.origin.y, playCountLable.frame.size.width, playCountLable.frame.size.height)];
                    faVOcuntLable.backgroundColor=[UIColor clearColor];
                    faVOcuntLable.text=[NSString stringWithFormat:@"%i",catModel.favoriteCount];
                    faVOcuntLable.font=[UIFont systemFontOfSize:10];
                    faVOcuntLable.textColor=color_2;
                    faVOcuntLable.tag=imgVIew.tag+10000;
                    faVOcuntLable.alpha=ALOPH;
//                    [self addSubview:faVOcuntLable];
                    
                }
            
                [imgVIew addSubview:favButton];
                
                UIImageView*imgVIew1 = [[UIImageView alloc] initWithFrame:CGRectMake(imgVIew.frame.origin.x - 16, imgVIew.frame.origin.y , imgVIew.frame.size.width + 32, imgVIew.frame.size.height + 20)];
                imgVIew1.image = [UIImage imageNamed:@"book_Selected2.png"];
                
//                UIImageView*imgVIew2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgVIew.frame.origin.x - 16, imgVIew.frame.origin.y + 3.5 , imgVIew.frame.size.width + 32, imgVIew.frame.size.height + 20)];
//                imgVIew2.image = [UIImage imageNamed:@"CloudCoverage2.png"];
//                [self addSubview:imgVIew1];
                [self addSubview:imgVIew];
                [self addSubview:imgVIew2];
                _titleLabe.frame = CGRectMake(16,imgVIew2.frame.size.height - 35,(frame.size.width-182)/6,20);
            }

        }
        
        
    }
    return self;
}

-(void)showEPG:(UIButton*)sender{
//    UIImageView * img = (UIImageView *)sender.superview;
//    img.userInteractionEnabled = NO;
//    CHECK_NONERETURN(self.myArray.count > sender.tag - 1000);
//    ChannelCatContentListModel*catModel=[self.myArray objectAtIndex:sender.tag-1000];
//    if (liv==nil) {
//        liv=[[LiveEPGView alloc]initWithName:Nil];
//    }
//    [liv show:catModel];
//    [self performSelector:@selector(releaseImgViewUserInteractionEnabled:) withObject:img afterDelay:0.8];
}

-(void)releaseImgViewUserInteractionEnabled:(UIImageView *)img
{
    img.userInteractionEnabled = YES;
}

-(void)releaseBtnUserInteractionEnabled:(UIButton *)btn
{
    btn.userInteractionEnabled = YES;
}

-(void)clickImgeView:(UITapGestureRecognizer*)sender{
    if (duodian==NO) {
        duodian=YES;
        UIButton * btn = (UIButton *)[sender.view viewWithTag:sender.view.tag];
        btn.userInteractionEnabled = NO;
        self.userInteractionEnabled = NO;

        [AppDelegate App].selctImgCent=CGPointMake(sender.view.center.x+3, sender.view.center.y+120);
        if (_delegate!=nil) {
            [self.delegate callbackGatherClassName:[NSString stringWithFormat:@"%i",self.tag] count:sender.view.tag];
        }
        [self performSelector:@selector(huifu) withObject:self afterDelay:0.8];
        [self performSelector:@selector(releaseBtnUserInteractionEnabled:) withObject:btn afterDelay:0.8];
    }
    
}

-(void)huifu{
    duodian=NO;
    self.userInteractionEnabled = YES;

}

-(void)changeFavouriteCount:(UIButton*)sender
{
    if ([AppDelegate App].isLogin==NO) {
        [Commonality dismissAllView];
        return;
    }
    CHECK_NONERETURN(self.myArray.count > sender.tag - 1000);
    ChannelCatContentListModel*catModel=[self.myArray objectAtIndex:sender.tag-1000];
    UILabel*lab=(UILabel*)[self viewWithTag:sender.tag+10000];
    if (catModel.isCollect==0) {
        lab.text=[NSString stringWithFormat:@"%i",lab.text.intValue+1];
        return;
    }else{
        lab.text=[NSString stringWithFormat:@"%i",lab.text.intValue-1];
        return;
    }

}

-(void)clickFavButton:(UIButton*)sender{
    if (![AppDelegate App].isLogin) {
        MainViewController * main = (MainViewController *)[[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
        [main clickUserButton:nil];
        return;
    }
    CHECK_NONERETURN(self.myArray.count > sender.tag - 1000);
    ChannelCatContentListModel*catModel=[self.myArray objectAtIndex:sender.tag-1000];
    UILabel*lab=(UILabel*)[self viewWithTag:sender.tag+10000];
   
    if (catModel.isCollect==0) {
        lab.text=[NSString stringWithFormat:@"%i",lab.text.intValue+1];
        if ([catModel.contentType isEqualToString:@"live"]) {
            [sender setBackgroundImage:[UIImage imageNamed:@"Collection2.png"] forState:(UIControlStateNormal)];
        }else{
            [sender setBackgroundImage:[UIImage imageNamed:@"onLIveCollec2.png"] forState:(UIControlStateNormal)];
        }
        
        catModel.isCollect=1;
        catModel.favoriteCount +=1;
        [HttpRequest addFavorRequest:[AppDelegate App].personModel.tokenid contentGiud:catModel.contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        
        if ([catModel.contentType isEqualToString:@"live"]) {
            [sender setBackgroundImage:[UIImage imageNamed:@"Collection3.png"] forState:(UIControlStateNormal)];
        }else{
            [sender setBackgroundImage:[UIImage imageNamed:@"onLIveCollec.png"] forState:(UIControlStateNormal)];
        }
        lab.text=[NSString stringWithFormat:@"%i",lab.text.intValue-1];
        catModel.isCollect=0;
        catModel.favoriteCount -=1;
        [HttpRequest caelFavorWithConteng:[AppDelegate App].personModel.tokenid contentGiud:catModel.contentGuid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    
}


-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
    }else{
        if (request.tag==ADDFAVORITE_TYPE){
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                
            }else{
                 [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];
            }
        }else if (request.tag==CANFAVORITE_TYPE){
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                
            }else{
               
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:@"网络连接异常，请重试"];

            }
        }
        
        
    }
}


@end















