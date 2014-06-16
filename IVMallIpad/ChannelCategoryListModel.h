//
//  ChannelCategoryListModel.h
//  IVMall (Ipad)
//
//  Created by SMiT on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelCategoryListModel : NSObject

@property(nonatomic,assign)int result;
@property(nonatomic,strong)NSString* selectedCategoryId;
@property(nonatomic,strong)NSString* categoryId;
@property(nonatomic,strong)NSString* categoryName;
@property(nonatomic,strong)NSString* categoryDescription;
@property(nonatomic,strong)NSString* categoryImg;
@property(nonatomic,strong)NSString* categroyFrom;


- (id)initWithDictionary:(NSDictionary *)dictionary modelList:(NSMutableArray *)mList page:(int)page;
@end
