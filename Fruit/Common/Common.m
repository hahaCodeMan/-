//
//  Common.m
//  CookDemo
//
//  Created by kakaYiGen on 15-3-30.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "Common.h"

@implementation Common

#pragma mark 创建Label
+ (UILabel *)createLabelWith:(CGRect)frame
                        text:(NSString *)text
                         tag:(NSInteger)tag
                   textColor:(UIColor *)color
                        font:(UIFont *)font{

    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.tag = tag;
    label.text  = text;
    label.textColor = color;
    label.font = font;
    return label;
    
}

#pragma mark 计算文本Size
+ (CGSize)calcTextSize:(NSString *)text
              fontSize:(CGFloat)fontSize
         constrainSize:(CGSize)constrainSize
         attirbuteDict:(NSDictionary *)dict{
    
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    if(SYS_VERSION <= 6.0){
        return  [text sizeWithFont: font constrainedToSize: constrainSize];
    }else{
        return [text boundingRectWithSize:constrainSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    }
 
}

#pragma mark 创建Button
+ (UIButton *)createBtnWith:(CGRect)frame
                  title:(NSString *)title
                  image:(UIImage *)image
                    tag:(NSInteger)tag
                 target:(id)target
                    sel:(SEL)sel
                  event:(UIControlEvents)event{
    
    UIButton * btn;
    if(!image){
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }else{
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    [btn setFrame:frame];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:event];
    
    return btn;
    
}

#pragma mark 创建ImageView
+ (UIImageView *)createImageViewWith:(CGRect)frame
                           image:(UIImage *)img
                             tag:(NSInteger)tag
                     isUserInfer:(BOOL)isUserInfer{

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = img;
    imageView.tag = tag;
    imageView.userInteractionEnabled = isUserInfer;
    return imageView;
}

#pragma mark 创建ScrollView
+ (UIScrollView *)createScrollViewWith:(CGRect)frame
                           contentSize:(CGSize)contentSize
                               bounces:(BOOL)isBounces
                         pagingEnabled:(BOOL)isPagingEnabled
                              delegate:(id)delegate
                                   tag:(NSInteger)tag{

    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = contentSize;
    scrollView.bounces = isBounces;
    scrollView.pagingEnabled = isPagingEnabled;
    scrollView.delegate = delegate;
    scrollView.tag = tag;
    return scrollView;
}

#pragma mark 弹出提示窗口AlertView
+ (void)alertShowMsg:(NSString*)msg
            delegate:(id)delegate
          okBtnTitle:(NSString*)okTitle
      cancelBtnTitle:(NSString*)cancelTitle
                 tag:(NSInteger)tag{

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:okTitle, nil];
    
    [alert show];
}

/**
 *  验证邮箱是否正确
 *
 *  @param email 邮箱
 *
 *  @return 返回验证结果
 */
+ (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark - NSUserDefaults
#pragma mark 写入NSUserDefaults
+ (void)wirteToUserDefaults:(NSDictionary *)parameters{

    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    
    for (id key in parameters.allKeys) {
        
        [def setObject:[parameters objectForKey:key] forKey:key];
    }
    
    [def synchronize];
}

#pragma mark 判断NSUserDefaults 是否存在
+ (NSArray *)isExistsUserDefaults:(NSArray *)parameters{
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * mArray = [NSMutableArray array];
    [parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        if([def objectForKey:obj]){

            [mArray addObject:obj];
        }
    }]; 
    return mArray;
}

#pragma mark 返回分割后的首个字符串
/**
 *  获取分割后的首个字符串
 *
 *  @param charSet 分割字符集合
 *  @param string  分割字符串
 *
 *  @return 返回结果
 */
+ (NSString *)commonSeparatedByCharactersInSet:(NSCharacterSet *)charSet
                                      ForString:(NSString *)string{
    NSArray * array =  [string componentsSeparatedByCharactersInSet:charSet];
    return array[0];
}

#pragma mark 返回合并后的字符串
/**
 *  根据指定的字符合并字符串
 *
 *  @param charSet 指定合并字符串的字符串
 *  @param array   合并元素
 *
 *  @return 返回合并后的字符串
 */
+ (NSString *)joinByCharactersInSet:(NSString *)charSet
                            forArray:(NSString *)array{

    NSMutableArray * mArray = [array mutableCopy];
    return  [mArray componentsJoinedByString:charSet];
}



@end
