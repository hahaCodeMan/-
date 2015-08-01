//
//  RegistView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "RegistView.h"

@interface RegistView ()<UITextFieldDelegate>{

    __weak IBOutlet UITextField *_txtNickName;
    __weak IBOutlet UITextField *_lblEmail;
    __weak IBOutlet UITextField *_txtPwd;
    
    
}

@end

@implementation RegistView



- (void)awakeFromNib{

    _txtNickName.delegate = self;
    _lblEmail.delegate = self;
    _txtPwd.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{

    NSDictionary * userInfo = [notification userInfo];
    
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect  keyboardValue = [value CGRectValue];
    int heigth = keyboardValue.size.height;
    CGPoint point = self.center;
    point.y -= heigth / 2;
    self.center = point;
    
}

- (void)keyboardWillHide:(NSNotification *)notification{

    NSDictionary * userInfo = [notification userInfo];
    
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGRect  keyboardValue = [value CGRectValue];
    int heigth = keyboardValue.size.height;
    CGPoint point = self.center;
    point.y += heigth / 2;
    self.center = point;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}
- (IBAction)btnClick:(UIButton *)sender {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"123456" forKey:@"password"];
    [dict setObject:@"443257643@qq.com" forKey:@"email"];
    [dict setObject:@"yyy" forKey:@"nickname"];
    
    if(self.returnPara){
    
        self.returnPara(dict);
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
