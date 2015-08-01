//
//  ShopDetailFootView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "ShopDetailFootView.h"
#import "NewProductModel.h"
#import "UIImageView+AFNetworking.h"
#import "Common.h"
#define SIMILARY_ENTITY_COUNT 4
@interface ShopDetailFootView() {

    __weak IBOutlet UIView *_writeView;
    
    __weak IBOutlet UIView *_similarEntitys;
}

@end
@implementation ShopDetailFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setEntitys:(NSArray *)entitys{
    _entitys = entitys;
    
    for (NSInteger i = 0; i < SIMILARY_ENTITY_COUNT; i++) {
        
        NewProductModel * entityModel = _entitys[i];
        
        UIImageView * imageView = [Common createImageViewWith:CGRectMake(10 + i * 90, 5, 80, 80) image:nil tag:1000 + i isUserInfer:YES];
        
        [imageView setImageWithURL:[NSURL URLWithString:entityModel.chief_image]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [imageView addGestureRecognizer:tap];
        [_similarEntitys addSubview:imageView];
        
    }
    
}
#pragma mark 手势处理事件
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    //点击写评论
    if(sender.view.tag == 100){
        if(self.cb){
            //Block回调
            self.cb([NSString stringWithFormat:@"%ld",sender.view.tag]);
        }
    }else{
        //点击相似商品
        if(self.cb){
            self.cb([NSString stringWithFormat:@"%ld", [_entitys[sender.view.tag - 1000] entity_id]]);
        }
    }
}

- (void)awakeFromNib{

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [_writeView addGestureRecognizer:tap];
}

@end
