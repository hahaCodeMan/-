//
//  SortView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnFlg) (NSInteger tag);
@interface SortView : UIView

@property (nonatomic,copy)ReturnFlg returnFlg;
@end
