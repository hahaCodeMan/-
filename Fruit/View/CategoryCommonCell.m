//
//  CategoryCommonCell.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "CategoryCommonCell.h"

@interface CategoryCommonCell(){

    
    __weak IBOutlet UILabel *_lblName;
}

@end
@implementation CategoryCommonCell

- (void)setTitleName:(NSString *)titleName{ 
    NSString * string = titleName;
    _lblName.text = [string componentsSeparatedByString:@"-"][0];
}



- (void)awakeFromNib {
    // Initialization code
}

@end
