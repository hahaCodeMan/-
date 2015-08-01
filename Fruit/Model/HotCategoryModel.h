//
//  HotCategoryModel.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCategoryModel : NSObject

@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger category_id;
@property (nonatomic,assign)NSInteger group_id;
@property (nonatomic,copy)NSString * category_icon_large;
@property (nonatomic,copy)NSString * category_title;
@property (nonatomic,copy)NSString * category_icon_small;

- (id)initWithDict:(NSDictionary *)dict;
@end
