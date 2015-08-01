//
//  TagCell.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"
@interface TagCell : UITableViewCell
@property(nonatomic,strong)TagModel * tagModel;

+ (CGFloat)cellHigth;
@end
