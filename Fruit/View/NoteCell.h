//
//  NoteCell.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NewProductModel.h"
typedef void(^ReturnCellHight) (CGFloat cellHight);
@interface NoteCell : UITableViewCell
@property(nonatomic,strong)Note * noteModel;
@property(nonatomic,strong)NewProductModel * entityModel;
@property (nonatomic,copy)ReturnCellHight cbHight;
+ (CGFloat)cellHight;
@end
