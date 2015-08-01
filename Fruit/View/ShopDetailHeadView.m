//
//  ShopDetailHeadView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "ShopDetailHeadView.h"
#import "NewProductModel.h"
#import "Creator.h"
#import "UIImageView+AFNetworking.h"
#import "Common.h"
#import "WebViewController.h"
#define USER_HEADER_COUNT 8
@interface ShopDetailHeadView (){

    __weak IBOutlet UILabel *_lblShopName;
    __weak IBOutlet UIImageView *_shopImage;
    
    __weak IBOutlet UILabel *_lblLikeCount;
    
    __weak IBOutlet UIView *_userHeadListView;
    
    __weak IBOutlet UIButton *_btnApply;
    __weak IBOutlet UILabel *_lblFrom;
}

@end

@implementation ShopDetailHeadView
- (IBAction)onBtnClick:(UIButton *)sender {
    
    NewProductModel * model = [[_dataArray firstObject] lastObject];
    
    if(self.entityLink){
    
        self.entityLink([model.item_list lastObject][@"buy_link"]);
    }
}

#pragma mark - 绑定数据
- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
    
    [self setEntityData:[_dataArray firstObject]];
    
    [self setUserHeadList:[_dataArray lastObject]];
    
}


/**
 *  绑定商品信息数据
 *
 *  @param entity 数据源
 */
- (void)setEntityData:(NSArray *)entity{

    NewProductModel * model = [entity lastObject];
    _lblShopName.text = [Common commonSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"] ForString:model.title];
    [_shopImage setImageWithURL:[NSURL URLWithString:model.chief_image]];
    _lblLikeCount.text = [NSString stringWithFormat:@"喜爱%ld",model.like_count];
//    _btnApply.text = [NSString stringWithFormat:@"￥%@",model.price];
    [_btnApply setTitle:[NSString stringWithFormat:@"￥%@",model.price] forState:UIControlStateNormal];
}

/**
 *  绑定喜欢商品用户头像列表
 *
 *  @param users 数据源
 */
- (void)setUserHeadList:(NSArray *)users{

    for (NSInteger i = 0; i < USER_HEADER_COUNT; i++) {
        
        Creator * userModel = users[i];
        
        UIImageView * imageView = [Common createImageViewWith:CGRectMake(5 + i * 43, 0, 40, 38) image:nil tag:userModel.user_id isUserInfer:YES];
        
        [imageView setImageWithURL:[NSURL URLWithString:userModel.avatar_small]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [imageView addGestureRecognizer:tap];
        [_userHeadListView addSubview:imageView];
        
        if(users.count <= 1)return;
        
    }
}

#pragma mark 手势处理事件
- (void)onTap:(UITapGestureRecognizer *)sender{

    if(self.userIDCb){
    
        self.userIDCb(sender.view.tag);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
