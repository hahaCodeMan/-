//
//  CategoryMdodel.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "CategoryMdodel.h"

@implementation CategoryMdodel

- (id)initWithDict:(NSDictionary *)dict{
    
    if(self = [super init]){
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
