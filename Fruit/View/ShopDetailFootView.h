//
//  ShopDetailFootView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WriteNoteCb) (NSString * str);
@interface ShopDetailFootView : UIView

@property(nonatomic,strong)NSArray * entitys;
@property (nonatomic,copy)WriteNoteCb cb;
@end
