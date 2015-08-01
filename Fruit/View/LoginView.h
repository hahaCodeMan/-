//
//  LoginView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AppLoginCb)(NSInteger appFlg);
@interface LoginView : UIView
@property (nonatomic,copy)AppLoginCb loginCb;


@end
