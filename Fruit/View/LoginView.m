//
//  LoginView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()<UITextFieldDelegate>{

    __weak IBOutlet UITextField *_txtEmail;
    
    __weak IBOutlet UITextField *_txtPwd;
}

@end

@implementation LoginView

- (void)awakeFromNib{

    _txtEmail.delegate = self;
    _txtPwd.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWillShow:(NSNotification *)notification{

    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int heigth = keyboardRect.size.height;
    CGPoint point = self.center;
    point.y -= heigth / 2;
    
    self.center = point;
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int heigth = keyboardRect.size.height;
    CGPoint point = self.center;
    point.y += heigth / 2;
    self.center = point;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
            break;
        case 101:
        case 103:{
            if(self.loginCb){
                self.loginCb(sender.tag);
            }
        }
            break;
        default:
            break;
        }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
