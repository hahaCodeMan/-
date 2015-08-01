//
//  NoteCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "NoteCell.h"
#import "UIImageView+AFNetworking.h"
#import "Creator.h"
#import "NewProductModel.h"
#import "Common.h"
#define CellHight 245
@interface NoteCell (){

    __weak IBOutlet UIView *_topView;
    __weak IBOutlet UIImageView *_headViewSmall;
    __weak IBOutlet UILabel *_lblRecomment;
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UIImageView *_headViewBig;
    __weak IBOutlet UILabel *_lblShopName;
    __weak IBOutlet UILabel *_lblprice;
    __weak IBOutlet UILabel *_lblFavorite;
    __weak IBOutlet UILabel *_lblRecomentCount;
    __weak IBOutlet UIView *_subBottomView;
    __weak IBOutlet UIView *_bottomView;
    __weak IBOutlet UILabel *_lblNoteContent;
    __weak IBOutlet UILabel *_lblPraise;
    __weak IBOutlet UILabel *_lblDate;
    
    __weak IBOutlet UIImageView *_imgPrise;
    UILabel * _label;
    UIView * _view;

}

@end

@implementation NoteCell

+ (CGFloat)cellHight{

    return 250;
}


/**
 *  设置评论人数据
 *
 *  @param dict 数据源
 */
- (void)setCreatorModelWith:(NSDictionary *)dict{

    Creator * creator = [[Creator alloc] initWithDic:dict];
    
    _headViewSmall.layer.cornerRadius = 10;
    _headViewSmall.clipsToBounds = YES;
    [_headViewSmall setImageWithURL:[NSURL URLWithString:creator.avatar_small]];
    CGSize lblSize =  [Common calcTextSize:creator.nickname fontSize:13.0f constrainSize:CGSizeMake(300, 9999) attirbuteDict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    CGRect frame = _userName.frame;
    CGRect lblFrame = _lblRecomment.frame;
    lblFrame.origin.x = frame.origin.x + lblSize.width;
    _lblRecomment.frame = lblFrame ;
    _userName.text = creator.nickname;
}

/**
 *  设置评论数据
 *
 *  @param noteModel 数据源
 */
- (void)setNoteModel:(Note *)noteModel{

    _noteModel = noteModel;
    [self setCreatorModelWith:_noteModel.creator];
    _lblNoteContent.text = _noteModel.content;
    _lblPraise.text = [NSString stringWithFormat:@"%ld",_noteModel.poke_count];
    [self setCellHeight:_lblNoteContent.text];
    [self setDate:_noteModel.post_time];
}

- (void)setCellHeight:(NSString *)text{
   
    CGSize bottomSize = [Common calcTextSize:text fontSize:13.0f constrainSize:CGSizeMake(320, 9999) attirbuteDict:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
    _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y, bottomSize.width, bottomSize.height);
    _label.text = text;
    _subBottomView.frame = CGRectMake(_subBottomView.frame.origin.x, _label.frame.origin.y + _label.frame.size.height, _subBottomView.frame.size.width, _subBottomView.frame.size.height);
    _bottomView.frame = CGRectMake(0, _bottomView.frame.origin.y, _bottomView.frame.size.width, _label.frame.size.height + _subBottomView.frame.size.height + 10);
    
    self.frame =CGRectMake(0, 0, self.frame.size.width, _topView.frame.size.height + _bottomView.frame.size.height);
}

- (void)setDate:(NSString *)date{
    
    NSCharacterSet * charSet = [NSCharacterSet characterSetWithCharactersInString:@"- "];
    NSArray * array = [date componentsSeparatedByCharactersInSet:charSet];
    NSString * dateString = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
    _lblDate.text = dateString;
    
}

/**
 *  设置商品数据
 *
 *  @param entityModel 数据源
 */
- (void)setEntityModel:(NewProductModel *)entityModel{

    _entityModel = entityModel;
    [_headViewBig setImageWithURL:[NSURL URLWithString:_entityModel.chief_image]];
    _lblShopName.text = _entityModel.title;
    _lblprice.text = [NSString stringWithFormat:@"￥%@",_entityModel.price];
    _lblFavorite.text = [NSString stringWithFormat:@"%ld",_entityModel.like_count];
    _lblRecomentCount.text = [NSString stringWithFormat:@"%ld",_entityModel.note_count];
}

- (void)awakeFromNib {
    // Initialization code
    _lblNoteContent.hidden = YES;
    _label = [Common createLabelWith:_lblNoteContent.frame text:nil tag:0 textColor:nil font:nil];
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:13.0f];
    [_bottomView addSubview:_label];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
