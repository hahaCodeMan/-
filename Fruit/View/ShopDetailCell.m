//
//  ShopDetailCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "ShopDetailCell.h"
#import "Common.h"
#import "Creator.h"
#import "UIImageView+AFNetworking.h"
@interface ShopDetailCell(){

    __weak IBOutlet UIImageView *_headView;
    
    __weak IBOutlet UILabel *_lblName;

    __weak IBOutlet UILabel *_lblNote;
    __weak IBOutlet UILabel *_lblPriseCount;

    __weak IBOutlet UILabel *_lblNoteCount;
    __weak IBOutlet UILabel *_lblDate;

    __weak IBOutlet UIView *_bottomView;
}

@end
@implementation ShopDetailCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setNote:(Note *)note{
    _note = note;
    NSDictionary * creatorDict = _note.creator;
    Creator * creator = [[Creator alloc] initWithDic:creatorDict];
    _lblName.text = creator.nickname;
    _lblNote.text = note.content;
    _lblNoteCount .text = [NSString stringWithFormat:@"%ld",note.comment_count ];
    _lblPriseCount.text = [NSString stringWithFormat:@"%ld",note.poke_count];
    _lblDate.text = [self setDate:note.post_time];
    [_headView setImageWithURL:[NSURL URLWithString:creator.avatar_small ]];
    [self setCellHigth:_lblNote.text];

}

- (NSString *)setDate:(NSString *)date{
    NSArray * array = [date componentsSeparatedByString:@" "];
    return array[0];
}

- (void)setCellHigth:(NSString *)text{
    
    CGSize textSize = [Common calcTextSize:text fontSize:13.0f constrainSize:CGSizeMake(280, 9999) attirbuteDict:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    _lblNote.frame = CGRectMake(_lblNote.frame.origin.x, _lblNote.frame.origin.y, textSize.width, textSize.height);
    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, _lblNote.frame.origin.y + _lblNote.frame.size.height + 10 , _bottomView.frame.size.width, _bottomView.frame.size.height);
    CGRect frame = self.frame;
    frame.size.height = 25 + _lblNote.frame.size.height + _bottomView.frame.size.height + 15;
    self.frame =frame;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
