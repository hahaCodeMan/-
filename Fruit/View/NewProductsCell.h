//
//  NewProductsCell.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProductModel.h"

typedef void(^FavoriteClickCb)(NSString * str);
@interface NewProductsCell : UITableViewCell

@property(nonatomic,strong)NewProductModel * products;
@property (nonatomic,copy)FavoriteClickCb clickCallBack;
+ (CGFloat)cellHeight;
@end
