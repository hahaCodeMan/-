//
//  ConvertJson.m
//  COOKING
//
//  Created by kakaYiGen on 15-3-25.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "ConvertJson.h"

@implementation ConvertJson


#pragma mark 把NSData 数据转换为数组
+ (NSArray *)ConvertJsonDataToArray:(NSData *)data error:(NSError *)error{

    
   NSArray * array =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    return array;
    
}

#pragma mark 把NSData 数据转换为字典
+ (NSDictionary *)ConvertJsonDataToDictionary:(NSData *)data error:(NSError *)error{

    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    return dictionary;
    
    
}

#pragma mark 把数组或者字典转换程NSData
+ (NSData *)ConvertObjectToData:(id)object error:(NSError *)error{

   NSData * data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    return data;
    
}


@end
