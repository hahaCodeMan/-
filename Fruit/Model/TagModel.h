//
//  TagModel.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

@property (nonatomic,copy)NSString * tag_hash;
@property (nonatomic,copy)NSString * tag;
@property (nonatomic,assign)NSInteger entity_count;
@property (nonatomic,assign)NSInteger tag_id;

- (id)initWithDict:(NSDictionary *)dict;
@end
