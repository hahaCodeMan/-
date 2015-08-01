//
//  NewProductsCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "NewProductsCell.h"
#import "UIImageView+AFNetworking.h"
#import "Common.h"
@interface NewProductsCell(){

    
    __weak IBOutlet UIImageView *_headView;
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UILabel *_lblFavorite;
    __weak IBOutlet UILabel *_lblComment;
    
}

@end
@implementation NewProductsCell

- (IBAction)btnFavoriteClick:(UIButton *)sender {
    
    if(self.clickCallBack){
    
        self.clickCallBack([NSString stringWithFormat:@"%@",_products.title]);
    }
    
}

- (void)setProducts:(NewProductModel *)products{
    _products = products;
    [_headView setImageWithURL:[NSURL URLWithString:_products.chief_image]];
    _lblTitle.text = [Common commonSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"] ForString:_products.title];
    _lblPrice.text = [NSString stringWithFormat:@"￥%@",_products.price];
    _lblFavorite.text = [NSString stringWithFormat:@"%ld",_products.like_count];
    _lblComment.text = [NSString stringWithFormat:@"%ld",_products.note_count];
}

+ (CGFloat)cellHeight{

    return 80;
}
- (void)awakeFromNib {
    // Initialization code
    
    
    _headView.layer.cornerRadius = 10;
    
    _headView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
