//
//  EntityCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "EntityCell.h"
#import "UIImageView+AFNetworking.h"
@interface EntityCell(){

    __weak IBOutlet UIImageView *_entityImage;
    
}

@end
@implementation EntityCell

- (void)setEntity:(NewProductModel *)entity{

    _entity = entity;
    [_entityImage setImageWithURL:[NSURL URLWithString:entity.chief_image]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
