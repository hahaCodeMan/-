//
//  LeftViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "LeftViewController.h"
#import "HomePageViewController.h"
#import "RegisterViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (IBAction)btnClick:(UIButton *)sender {

    switch (sender.tag) {
            
        case 100:{
            [self showLoginView];
        }
            break;
        case 101:{
            
            [[self returnAppDelegate].menuController showRootController:YES];
          
            
        }
            break;
        case 102:{
            UINavigationController * rootVC = (UINavigationController *)[self returnAppDelegate].menuController.rootViewController;
            SearchViewController * search = [[SearchViewController alloc] init];
            [[self returnAppDelegate].menuController showRootController:YES];
            [rootVC pushViewController:search animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
