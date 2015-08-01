//
//  HotCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HotCell.h"
#import "Common.h"
#import "HotCategoryModel.h"
#import "UIImageView+AFNetworking.h"
#define Count 8
@implementation HotCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHotCategory:(NSArray *)hotCategory{

    NSLog(@"==<<<<<<<<<<<<<<<%@",hotCategory);
    _hotCategory = hotCategory;
    
    for (NSInteger i = 0; i < Count; i++) {
        HotCategoryModel * model = _hotCategory[i];
        
        NSLog(@">>%@",model.category_icon_small);
        NSInteger row = i / 4;
        NSInteger col = i % 4;
        UIImageView * imageView = [Common createImageViewWith:CGRectMake(5 + 80 * col, 5 + 80 * row, 80, 80) image:nil tag:1000 + i isUserInfer:YES];
        UILabel * label = [Common  createLabelWith:CGRectMake(0, imageView.bounds.size.height - 20, 80, 20) text:model.category_title tag:10000 + i textColor:nil font:nil];
        label.alpha = 0.5;
        if(i == Count - 1){
            
            imageView.image = [UIImage imageNamed:@"icon_homepage_more"];
            label.text = @"更多品类";
            
        }else{
            
            [imageView setImageWithURL:[NSURL URLWithString:model.category_icon_small]];
        }
        [imageView addSubview:label];
        [self.contentView addSubview:imageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
