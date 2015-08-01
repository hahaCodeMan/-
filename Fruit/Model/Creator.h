//
//  Creator.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Creator : NSObject
@property (nonatomic,assign)BOOL is_censor;
//is_censor: false,
//bio: "果库哥",
@property (nonatomic,copy)NSString * bio;
//avatar_large: "http://imgcdn.guoku.com/avatar/large_3_00a79ec67c5a2ad7f105df27ea81ee2c.jpg",
@property (nonatomic,copy)NSString * avatar_large;
//user_id: 3,
@property (nonatomic,assign)NSInteger user_id;
//following_count: 483,
@property (nonatomic,assign)NSInteger following_count;
//fan_count: 1410,
@property (nonatomic,assign)NSInteger fan_count;
//city: "朝阳",
@property (nonatomic,copy)NSString * city;
//gender: "M",
@property (nonatomic,copy)NSString * gender;
//sina_screen_name: "",
@property (nonatomic,copy)NSString * sina_screen_name;
//avatar_small: "http://imgcdn.guoku.com/avatar/large_3_00a79ec67c5a2ad7f105df27ea81ee2c.jpg",

@property (nonatomic,copy)NSString * avatar_small;
//is_active: "1",
@property (nonatomic,copy)NSString * is_active;
//entity_note_count: 14690,
@property (nonatomic,assign)NSInteger entity_note_count;
//tag_count: 72,
@property (nonatomic,assign)NSInteger tag_count;
//website: "http://kamyau.com/",
@property (nonatomic,copy)NSString * website;
//like_count: 1014,
@property (nonatomic,assign)NSInteger like_count;
//relation: 0,
@property (nonatomic,assign)NSInteger relation;
//location: "北京",
@property (nonatomic,copy)NSString * location;
//nickname: "liao",
@property (nonatomic,copy)NSString * nickname;
//email: "i@kamyau.com"
@property (nonatomic,copy)NSString * email;

- (id)initWithDic:(NSDictionary*)dict;
@end
