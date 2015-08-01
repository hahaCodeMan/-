//
//  TagCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "TagCell.h"
#import "Common.h"
@interface TagCell (){

    __weak IBOutlet UILabel *_lblTagName;
    
    __weak IBOutlet UILabel *_lblEntityCount;
}

@end

@implementation TagCell

+ (CGFloat)cellHigth{

    return 60;
}
- (void)setTagModel:(TagModel *)tagModel{

    _tagModel = tagModel;
    _lblTagName.text = [NSString stringWithFormat:@"#%@",tagModel.tag];
    _lblEntityCount.text = [NSString stringWithFormat:@"%ld件商品",tagModel.entity_count];
    [self setLabelFrame:_lblTagName.text];
}

- (void)setLabelFrame:(NSString *)text{

    CGSize txtSize = [Common calcTextSize:text fontSize:14.0f constrainSize:CGSizeMake(200, 9999) attirbuteDict:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    
    CGRect lblFrame = _lblTagName.frame;
    lblFrame.size = txtSize;
    _lblTagName.frame = lblFrame;
    
    CGRect frame = self.frame;
    frame.size.height = 10 + _lblTagName.frame.size.height + 20;
    self.frame = frame;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
