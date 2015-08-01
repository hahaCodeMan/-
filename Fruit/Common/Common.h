//
//  Common.h
//  CookDemo
//
//  Created by kakaYiGen on 15-3-30.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYS_VERSION [UIDevice currentDevice].systemVersion.floatValue

@interface Common : NSObject


#pragma mark 创建Label
+ (UILabel *)createLabelWith:(CGRect)frame
                        text:(NSString *)text
                         tag:(NSInteger)tag
                   textColor:(UIColor *)color
                        font:(UIFont *)font;


#pragma mark 计算文本Size
+ (CGSize)calcTextSize:(NSString *)text
              fontSize:(CGFloat)fontSize
         constrainSize:(CGSize)constrainSize
         attirbuteDict:(NSDictionary *)dict;


#pragma mark 创建Button
+ (UIButton *)createBtnWith:(CGRect)frame
                  title:(NSString *)title
                  image:(UIImage*)image
                    tag:(NSInteger)tag
                 target:(id)target
                    sel:(SEL)sel
                  event:(UIControlEvents)event ;

#pragma mark 创建ScrollView
+ (UIScrollView *)createScrollViewWith:(CGRect)frame
                           contentSize:(CGSize)contentSize
                               bounces:(BOOL)isBounces
                         pagingEnabled:(BOOL)isPagingEnabled
                              delegate:(id)delegate
                                   tag:(NSInteger)tag;

#pragma mark 创建ImageView
+ (UIImageView *)createImageViewWith:(CGRect)frame
                           image:(UIImage *)img
                             tag:(NSInteger)tag
                     isUserInfer:(BOOL) isUserInfer;
#pragma mark 弹出提示窗口AlertView
+ (void)alertShowMsg:(NSString*)msg delegate:(id)delegate okBtnTitle:(NSString*)okTitle cancelBtnTitle:(NSString*)cancelTitle tag:(NSInteger)tag;


#pragma mark 返回分割后的首个字符串
+ (NSString *) commonSeparatedByCharactersInSet:(NSCharacterSet *)charSet
                                      ForString:(NSString *)string;

#pragma mark 返回合并后的字符串
+ (NSString *) joinByCharactersInSet:(NSString *)charSet
                            forArray:(NSString *)array;

#pragma mark 写入NSUserDefaults
+ (void)wirteToUserDefaults:(NSDictionary *)parameters;

#pragma mark 判断数据是否存在NSUseDefaults
+ (NSArray *)isExistsUserDefaults:(NSArray *)parameters;

+ (BOOL)isValidateEmail:(NSString *)email;

@end
