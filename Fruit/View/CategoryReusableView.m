//
//  CategoryReusableView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "CategoryReusableView.h"

@interface CategoryReusableView (){

    

}

@end
@implementation CategoryReusableView

+ (CGSize) sectionHigth{

    return CGSizeMake(320, 40);
}
- (void)setModel:(CategoryEntityModel *)model{
    _model = model;
    _lblTitle.text = model.title;
}

- (void)onTap:(UITapGestureRecognizer *)sender{

    if(self .clickCb){
        self.clickCb(_indexPath);
    }
    
}
- (void)awakeFromNib {
    // Initialization code
   
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
    [self setUserInteractionEnabled: YES];
}

@end
