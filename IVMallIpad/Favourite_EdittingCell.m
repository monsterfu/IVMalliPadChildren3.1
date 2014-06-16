//
//  Favourite_EdittingCell.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "Favourite_EdittingCell.h"
#import "AppDelegate.h"
#import "CollectView.h"
#import "FavoriteListModel.h"
#import "PlayListModel.h"
#import "PlayHistoryView.h"

@implementation Favourite_EdittingCell

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


    // Configure the view for the selected state
}


- (IBAction)del:(id)sender {
    UIButton * btn = (UIButton *)sender;

    if (btn.imageView.image == [UIImage imageNamed:@"radio.png"]) {
        [btn setImage:[UIImage imageNamed:@"raido_sel.png"] forState:UIControlStateNormal];
        [AppDelegate.App.selectedDic setObject:[NSString stringWithFormat:@"%d",0] forKey:[NSString stringWithFormat:@"%d",btn.tag]];
//        CollectView * collect = (CollectView *) self.viewForBaselineLayout.superview.superview.superview;
        
        if (btn.tag > 19999) {
            PlayHistoryView * collect = nil;
            if ([AppDelegate App].isIOS7) {
                collect = (PlayHistoryView *) self.viewForBaselineLayout.superview.superview.superview;
                
            }else{
                collect = (PlayHistoryView *) self.viewForBaselineLayout.superview.superview;
                
            }
            CHECK_NONERETURN(collect.tableArray.count > btn.tag - 20000);
            PlayListModel * fm = [collect.tableArray objectAtIndex:btn.tag - 20000];
            fm.isSelect = NO;
            int count = 0;
            for (PlayListModel * fm1 in collect.tableArray) {
                if (fm1.isSelect) {
                    count++;
                }
            }
            if (count == 0) {
                [collect.delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
                collect.delSingleBtn.imageView.alpha = 0.3;
                collect.delSingleBtn.userInteractionEnabled = NO;
            }
            else
            {
                [collect.delSingleBtn setTitle:[NSString stringWithFormat:@"删除(%d)",count] forState:UIControlStateNormal];
                collect.delSingleBtn.imageView.alpha = 1;
                collect.delSingleBtn.userInteractionEnabled = YES;
            }
            return;
        }
     
        CollectView * collect = nil;
        if ([AppDelegate App].isIOS7) {
            collect = (CollectView *) self.viewForBaselineLayout.superview.superview.superview;
            
        }else{
            collect = (CollectView *) self.viewForBaselineLayout.superview.superview;
            
        }
        FavoriteListModel * fm = [collect.tableArray objectAtIndex:btn.tag];
        fm.isSelect = NO;
        int count = 0;
        for (PlayListModel * fm1 in collect.tableArray) {
            if (fm1.isSelect) {
                count++;
            }
        }
        if (count == 0) {
            [collect.delSingleBtn setTitle:@"删除" forState:UIControlStateNormal];
            collect.delSingleBtn.imageView.alpha = 0.3;
            collect.delSingleBtn.userInteractionEnabled = NO;
            
        }
        else
        {
            [collect.delSingleBtn setTitle:[NSString stringWithFormat:@"删除(%d)",count] forState:UIControlStateNormal];
            collect.delSingleBtn.imageView.alpha = 1;
            collect.delSingleBtn.userInteractionEnabled = YES;
        }
        return;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
        [AppDelegate.App.selectedDic setObject:[NSString stringWithFormat:@"%d",1] forKey:[NSString stringWithFormat:@"%d",btn.tag]];
        
        
      
        if (btn.tag > 19999) {
            PlayHistoryView * collect = nil;
            if ([AppDelegate App].isIOS7) {
                collect = (PlayHistoryView *) self.viewForBaselineLayout.superview.superview.superview;
                
            }else{
                collect = (PlayHistoryView *) self.viewForBaselineLayout.superview.superview;
                
            }
            CHECK_NONERETURN(collect.tableArray.count > btn.tag - 20000);
            PlayListModel * fm = [collect.tableArray objectAtIndex:btn.tag - 20000];
            fm.isSelect = YES;
            int count = 0;
            for (PlayListModel * fm in collect.tableArray) {
                if (fm.isSelect) {
                    count++;
                }
            }
            [collect.delSingleBtn setTitle:[NSString stringWithFormat:@"删除(%d)",count] forState:UIControlStateNormal];
            collect.delSingleBtn.imageView.alpha = 1;
            collect.delSingleBtn.userInteractionEnabled = YES;
            return;
        }
     
        
        CollectView * collect = nil;
        if ([AppDelegate App].isIOS7) {
            collect = (CollectView *) self.viewForBaselineLayout.superview.superview.superview;

        }else{
            collect = (CollectView *) self.viewForBaselineLayout.superview.superview;

        }
        FavoriteListModel * fm = [collect.tableArray objectAtIndex:btn.tag];
        fm.isSelect = YES;
        int count = 0;
        for (PlayListModel * fm in collect.tableArray) {
            if (fm.isSelect) {
                count++;
            }
        }
        [collect.delSingleBtn setTitle:[NSString stringWithFormat:@"删除(%d)",count] forState:UIControlStateNormal];
        collect.delSingleBtn.imageView.alpha = 1;
        collect.delSingleBtn.userInteractionEnabled = YES;
        return;
    }
}
@end
