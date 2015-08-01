//
//  CategoryReusableView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryEntityModel.h"
typedef void(^ItemClick) (NSIndexPath *  indexPath);
@interface CategoryReusableView : UICollectionReusableView

@property (nonatomic,strong)NSIndexPath * indexPath;

@property (nonatomic,copy)ItemClick  clickCb;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property(nonatomic,strong)CategoryEntityModel * model;

+ (CGSize)sectionHigth;
@end
