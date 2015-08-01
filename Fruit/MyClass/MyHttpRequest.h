//
//  MyHttpRequest.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MyHttpRequest : NSObject


+ (id)createInstance;

#pragma mark 请求热门品类数据
- (void)requestHotCategoryDataWithURL:(NSString *)url
                           parameters:(id)para
                               result:(void(^)(id data,NSError * error)) result;

#pragma mark 请求新品推荐数据
- (void)requestNewProductsDataWithURL:(NSString *)url
                           parameters:(id)para
                               result:(void(^)(id data,NSError * error))result;

#pragma mark 请求商品分类喜欢 评论 商品数
- (void)requestCategoryStatDataWithURL:(NSString *)url
                            parameters:(id)para
                                result:(void(^)(id data,NSError * error))result;

#pragma mark 请求评论数据
- (void)requestCategoryNoteDataWithURL:(NSString *)url
                            parameters:(id)para
                                result:(void(^)(id data,NSError * error))result;

#pragma mark 请求喜欢该商品的用户列表【详情】
- (void)requestLikeUserListDataWithURL:(NSString *)url
                            parameters:(id)para
                                result:(void(^)(id data,NSError * error))result;

#pragma mark 请求日热门，周热门数据
- (void)requestHotEntityDataWithURL:(NSString *)url
                         parameters:(id)para
                             result:(void(^)(id data,NSError * error))result;

#pragma mark 用户-喜欢-最后商品信息
- (void)requestUserLikeEntityDataWithURL:(NSString *)url
                              parameters:(id)para
                                  result:(void(^)(id data,NSError * error))result;

#pragma mark - 用户 请求其他喜欢商品数据
- (void)requestOtherEntityListDataWithURL:(NSString *)url
                               parameters:(id)para
                                   result:(void(^)(id data,NSError * error))result;
#pragma mark 请求用户标签数据
- (void)requestUserTagDataWithURL:(NSString *)url
                       parameters:(id)para
                           result:(void(^)(id data,NSError * error))result;

#pragma mark - 登录
- (void)requestLoginDataWithURL:(NSString *)url
                     parameters:(id)para
                         result:(void(^)(id data,NSError * error))result;

#pragma mark 请求商品分类列表数据 【搜索】
- (void)requestCategoryDataWithURL:(NSString *)url
                        parameters:(id)para
                            result:(void(^)(id data,NSError * error))result;
@end
