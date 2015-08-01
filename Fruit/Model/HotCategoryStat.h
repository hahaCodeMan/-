//
//  HotCategoryStat.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCategoryStat : NSObject

//like_count: 0,
@property (nonatomic,assign)NSInteger like_count;
//entity_count: 775,
@property (nonatomic,assign)NSInteger entity_count;
//entity_note_count: 2976
@property (nonatomic,assign)NSInteger entity_note_count;

- (id)initWithDict:(NSDictionary *)dict;
@end
