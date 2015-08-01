//
//  BaseViewController.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"
@interface BaseViewController : UIViewController
- (BOOL)isLoginUser;
- (void)showLoginView;
- (AppDelegate *)returnAppDelegate;
@end
