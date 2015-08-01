//
//  SortView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "SortView.h"

@interface SortView (){

}
@end
@implementation SortView

- (IBAction)btnClick:(UIButton *)sender {
    
    if(self.returnFlg){
        
        self.returnFlg(sender.tag);
    }
}

- (void)awakeFromNib{

    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
