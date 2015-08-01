//
//  WebViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-12.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "WebViewController.h"
#import "UIWebView+AFNetworking.h"
@interface WebViewController (){


    __weak IBOutlet UILabel *_lblTitle;
    
    __weak IBOutlet UIWebView *_webView;
}

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;

    _lblTitle.text = self.titleName;
}

- (IBAction)itemBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];

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
