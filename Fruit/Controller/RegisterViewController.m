//
//  RegisterViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginView.h"
#import "RegistView.h"
#import "CONST.h"
#import <ShareSDK/ShareSDK.h>
#import "MyHttpRequest.h"
@interface RegisterViewController (){

    LoginView * _loginView;
    RegistView * _registView;
    UIView * _alphaView;
}



@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    _alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.frame];
    _alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.7;
    [self.view addSubview:baseView];
    [self.view addSubview:_alphaView];
    [self loadxibView:_alphaView];
    
}

- (void)loadxibView :(UIView *)superView{
    __weak typeof (self) weakSelf = self;

    
    //加载登录窗口
    _loginView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    _loginView.center = self.view.center;
    [superView addSubview:_loginView];
    _registView = [[[NSBundle mainBundle] loadNibNamed:@"RegistView" owner:self options:nil] lastObject];
    _registView.center = self.view.center;
    [superView addSubview:_registView];
    
    _registView.hidden = YES;
    _registView.returnPara = ^(NSDictionary * para){
        [weakSelf register:para];
    };
    __weak typeof (RegistView *)weakRegisterView = _registView;
    __weak typeof (LoginView *)weakLoginView = _loginView;
    _loginView.loginCb = ^(NSInteger flg){
    
        switch (flg) {
            case 100:{
                [weakSelf login];
            }
                break;
            case 103:   //注册
                weakRegisterView.hidden = NO;
                weakLoginView.hidden = YES;
                break;
            default:
                break;
        }
    };
}

#pragma mark 登录
- (void)login{
    //点击登录
    if([self isLoginUser]) return;
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        
        if(result){
            [userInfo nickname];
            [userInfo uid];
            [userInfo gender];
            NSLog(@"%@,%@,%ld",[userInfo nickname],[userInfo uid],[userInfo gender]);
            //提交注册
        }
    }];
};


#pragma mark 注册
- (void)register:(NSDictionary *)para{
    [[MyHttpRequest createInstance] requestLoginDataWithURL:URL_USER_REGISTER parameters:para result:^(id data, NSError *error) {
        if(error){

#warning 缺少参数，注册时产生的 api_key and sign
            //注册失败
            NSLog(@"%@",error);
    
            [[self returnAppDelegate].menuController showLeftController:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        NSLog(@"%@",data);
    }];

}

#pragma mark 关闭窗口
- (void)dismissController{

    
    
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
