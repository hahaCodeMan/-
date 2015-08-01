//
//  ConvertJson.h
//  COOKING
//
//  Created by kakaYiGen on 15-3-25.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertJson : NSObject

+ (NSArray *)ConvertJsonDataToArray:(NSData *)data error:(NSError *)error;

+ (NSDictionary *)ConvertJsonDataToDictionary:(NSData *)data error:(NSError*)error;

+ (NSData *)ConvertObjectToData:(id)object error:(NSError *)error;

@end
