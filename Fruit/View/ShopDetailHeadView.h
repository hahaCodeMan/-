//
//  ShopDetailHeadView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnUserIDCb) (NSInteger userID);
typedef void(^ReturnEntityLink)(NSString *link);
@interface ShopDetailHeadView : UIView

@property(nonatomic,strong)NSArray * dataArray;

@property (nonatomic,copy)ReturnUserIDCb userIDCb;

@property (nonatomic,copy)ReturnEntityLink entityLink;
@end
