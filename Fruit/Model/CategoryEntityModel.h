//
//  CategoryEntityModel.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryEntityModel : NSObject


@property (nonatomic,assign)NSInteger status;

@property(nonatomic,strong)NSArray * content;
@property (nonatomic,assign)NSInteger category_count;
@property (nonatomic,assign)NSInteger group_id;
@property (nonatomic,copy)NSString * title;

- (id)initWithDict:(NSDictionary *)dict;
@end
