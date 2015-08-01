//
//  SearchGroupViewController.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "BaseViewController.h"

#import "CategoryEntityModel.h"
#import "CategoryMdodel.h"
@interface SearchGroupViewController : BaseViewController

@property (nonatomic,copy)NSString * titleName;

@property(nonatomic,strong) CategoryEntityModel* entityModel;

@property(nonatomic,strong)NSArray * dataArray;



@end
