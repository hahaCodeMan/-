//
//  Note.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Note : NSObject

//entity_id: "1481",
@property (nonatomic,copy)NSString * entity_id;
//post_time: "2011-05-09 11:31:28",
@property (nonatomic,copy)NSString * post_time;
//user_id: "3",
@property (nonatomic,copy)NSString * user_id;
//is_selected: 1,
@property (nonatomic,assign)NSInteger is_selected;
//poker_id_list: [ ],
@property(nonatomic,strong)NSArray * poker_id_list;
@property(nonatomic,strong)NSDictionary * creator;
//poke_already: 0,
@property (nonatomic,assign)NSInteger poke_already;
//updated_time: 1304911888,
@property (nonatomic,assign)NSInteger updated_time;
//content: "超级爱的一款壁挂式钥匙盒，俄罗斯进口橡木材质，表面是黑板，盒底有粉笔槽。里面的 16 个小挂钩，让生活更有序。",

@property (nonatomic,copy)NSString * content;
//comment_count: 0,
@property (nonatomic,assign)NSInteger comment_count;
//note_id: 9792,
@property (nonatomic,assign)NSInteger note_id;
//poke_count: 0,
@property (nonatomic,assign)NSInteger poke_count;
//created_time: 1304911888
@property (nonatomic,assign)NSInteger created_time;

- (id)initWithDic:(NSDictionary*)dict;
@end
