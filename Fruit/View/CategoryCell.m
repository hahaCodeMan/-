//
//  CategoryCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImageView+AFNetworking.h"
@interface CategoryCell(){

    __weak IBOutlet UIImageView *_headImage;
    
    __weak IBOutlet UILabel *_lblName;
}

@end
@implementation CategoryCell

- (void)setModel:(CategoryMdodel *)model{

    _model = model;
    
    [_headImage setImageWithURL:[NSURL URLWithString:model.category_icon_small]];
   
    NSString * string =  model.category_title;
    NSCharacterSet * charset = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    
    NSArray * array = [string componentsSeparatedByCharactersInSet:charset];
    _lblName.text = [array firstObject];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
