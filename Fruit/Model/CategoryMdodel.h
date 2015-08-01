//
//  CategoryMdodel.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryMdodel : NSObject


@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger category_id;
@property (nonatomic,copy)NSString * category_icon_small;
@property (nonatomic,copy)NSString * category_title;

- (id)initWithDict:(NSDictionary *)dict;
@end
