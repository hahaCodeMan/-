//
//  NewProductModel.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewProductModel : NSObject

//detail_images: [ ],
@property(nonatomic,strong)NSArray * detail_images;
//entity_id: 1457973,
@property (nonatomic,assign)NSInteger entity_id;
//weight: 0,
@property (nonatomic,assign)NSInteger weight;
//note_count: 0,
@property (nonatomic,assign)NSInteger note_count;
//price: "25.00",
@property (nonatomic,copy)NSString * price;
//intro: "",
@property (nonatomic,copy)NSString * intro;
//created_time: 1428570184,
@property (nonatomic,assign)NSInteger created_time;
//old_category_id: 152,
@property (nonatomic,assign)NSInteger old_category_id;
//chief_image: "http://imgcdn.guoku.com/images/a237766e48d086399f1bfefa8ba6d37c.jpg",
@property (nonatomic,copy)NSString * chief_image;
//entity_hash: "13259a05",
@property (nonatomic,copy)NSString * entity_hash;
//score_count: 0,
@property (nonatomic,assign)NSInteger score_count ;
//novus_time: 1428570184,
@property (nonatomic,assign)NSInteger novus_time;
//title: "玻璃造型钨丝灯",
@property (nonatomic,copy)NSString * title;
//mark: "none",
@property (nonatomic,copy)NSString * mark;
//brand: "",
@property (nonatomic,copy)NSString * brand;
//status: "0",
@property (nonatomic,copy)NSString * status;
//item_list: [],
@property(nonatomic,strong)NSArray * item_list;

@property (nonatomic,assign)NSInteger total_score;

@property(nonatomic,strong)NSArray * item_id_list;

@property (nonatomic,assign)NSInteger mark_value;

@property (nonatomic,assign)NSInteger like_already;

@property (nonatomic,assign)NSInteger old_root_category_id;

@property (nonatomic,assign)NSInteger updated_time;

@property (nonatomic,assign)NSInteger creator_id;

@property (nonatomic,assign)NSInteger like_count;

@property (nonatomic,copy)NSString * category_id;

- (id)initWithDict:(NSDictionary *)dict;

@end
