//
//  ChannelCategoryListModel.m
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ChannelCategoryListModel.h"

@implementation ChannelCategoryListModel//频道分类列表

- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray *)mList page:(int)page{
    if (self = [super init])
    {
        _result=[[dictionary objectForKey:@"errorCode"]intValue];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString* copyright=[userDefaultes objectForKey:@"copyright_Ivmall"];
        
        if (_result==0) {
            NSDictionary* data = [dictionary objectForKey:@"data"];
            _selectedCategoryId = [data objectForKey:@"selectedCategoryId"];
            NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"list"]];
            if(array){
                
                if (page==1) {
                    [mList removeAllObjects];
                    
                }
                for (NSDictionary *dic2 in array) {
                    
                    ChannelCategoryListModel *um=[[ChannelCategoryListModel alloc]initWithDictionaryEx:dic2];
                    
                    if ( copyright && [copyright isEqualToString:@"true"] )
                    {
                        [mList addObject:um];
                    }
                    else
                    {
                        if ([um.categoryName rangeOfString:@"直播"].location == NSNotFound) {
                            [mList addObject:um];
                        }
                    }
                    
                }
            }
        }
    }else{
        _result=-1;
    }
    return self;
}

- (id)initWithDictionaryEx:(NSDictionary *)dictionary{
    if (self=[super init]) {
        _categoryId = [dictionary objectForKey:@"categoryId"];
        _categoryName = [dictionary objectForKey:@"categoryName"];
        _categoryImg = [dictionary objectForKey:@"categoryImg"];
        _categroyFrom = [dictionary objectForKey:@"categroyFrom"];
        _categoryDescription = [dictionary objectForKey:@"categoryDescription"];
    }
    return self;
}

@end
