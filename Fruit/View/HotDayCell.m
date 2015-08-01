//
//  HotDayCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-12.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HotDayCell.h"
#import "UIImageView+AFNetworking.h"
@interface HotDayCell(){
    
    
    __weak IBOutlet UIImageView *_headView;
    
    __weak IBOutlet UILabel *_lblLikeCount;
    __weak IBOutlet UILabel *_lblPrice;
}

@end

@implementation HotDayCell

- (void)setEntity:(NewProductModel *)entity{

    _entity = entity;

    [_headView setImageWithURL:[NSURL URLWithString:_entity.chief_image]];
    _lblLikeCount.text = [NSString stringWithFormat:@"%ld",_entity.like_count];
    _lblPrice.text = [NSString stringWithFormat:@"￥%@",_entity.price];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
