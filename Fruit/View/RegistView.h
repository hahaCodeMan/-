//
//  RegistView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnParameters)(NSDictionary * para);
@interface RegistView : UIView

@property (nonatomic,copy)ReturnParameters returnPara;
@end
