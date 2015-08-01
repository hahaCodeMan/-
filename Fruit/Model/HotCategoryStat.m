//
//  HotCategoryStat.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HotCategoryStat.h"

@implementation HotCategoryStat

- (id)initWithDict:(NSDictionary *)dict{

    if(self = [super init]){
    
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
