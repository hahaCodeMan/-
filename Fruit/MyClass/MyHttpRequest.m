//
//  MyHttpRequest.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "MyHttpRequest.h"
#import "AFNetworking.h"
#import "HotCategoryModel.h"
#import "NewProductModel.h"
#import "ConvertJson.h"
#import "CONST.h"
#import "Note.h"
#import "HotCategoryStat.h"
#import "Creator.h"
#import "TagModel.h"
#import "CategoryEntityModel.h"
@interface MyHttpRequest (){

    AFHTTPRequestOperationManager * _manager;
}

@end

@implementation MyHttpRequest


#pragma mark 创建单例
+ (id)createInstance{

    static dispatch_once_t onceToken;
    static MyHttpRequest * request = nil;
    dispatch_once(&onceToken, ^{
        request = [[MyHttpRequest alloc] init];
    });
    return request;
}

- (id)init{

    if(self = [super init]){
    
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

#pragma mark - 首页
#pragma mark 请求热门品类数据
- (void)requestHotCategoryDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error)) result{
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        NSMutableArray * arrayS = [NSMutableArray array];
        NSArray * arrayBanner = dict[@"banner"];
        [arrayS addObject:arrayBanner];
        NSArray * arrayDiscover = dict[@"discover"];
        NSMutableArray * array = [NSMutableArray array];
        for (NSDictionary * dict in arrayDiscover) {
             HotCategoryModel * model = [[HotCategoryModel alloc] initWithDict:dict];
            [array addObject:model];
        }
        [arrayS addObject:array];
        if(result){
            result(arrayS,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        if(result){
        
            result(nil,error);
        }
    }];
    
}

#pragma mark 请求新品推荐数据 【通用】
- (void)requestNewProductsDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSArray * array = [ConvertJson ConvertJsonDataToArray:responseObject error:nil];
        NSMutableArray * dataArray = [NSMutableArray array];
        for (NSDictionary * dict in array) {
            NewProductModel * model = [[NewProductModel alloc] initWithDict:dict];
            [dataArray addObject:model];
        }
        if(result){
            result(dataArray,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
        
            result(nil,error);
        }
    }];
}

#pragma mark 请求商品分类喜欢 评论 商品数【热门品类】
- (void)requestCategoryStatDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        HotCategoryStat * stat = [[HotCategoryStat alloc] initWithDict:dict];
        if(result){
            result(stat,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
    result(nil,nil);
        }
    }];
}

#pragma mark 请求评论数据
- (void)requestCategoryNoteDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * array = [ConvertJson ConvertJsonDataToArray:responseObject error:nil];
        NSMutableArray * mNoteArray = [NSMutableArray array];
        NSMutableArray * mEntityArray = [NSMutableArray array];
        for (NSDictionary * noteDict in array) {
            NSDictionary * note = [noteDict objectForKey:@"note"];
            Note * noteModel = [[Note alloc] initWithDic:note];
            [mNoteArray addObject:noteModel];
            NSDictionary * entity = [noteDict objectForKey:@"entity"];
            NewProductModel * entityModel = [[NewProductModel alloc] initWithDict:entity];
            [mEntityArray addObject:entityModel];
        }
        if(result){
            result(@[mNoteArray,mEntityArray],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,nil);
        }
    }];
}

#pragma mark 请求喜欢该商品的用户列表【详情】
- (void)requestLikeUserListDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        //请求用户列表
        NSArray * userList = dict[@"like_user_list"];
        NSMutableArray * userArray = [NSMutableArray array];
        for (NSDictionary * user in userList) {
            Creator * userModel = [[Creator alloc] initWithDic:user];
            [userArray addObject:userModel];
        }
        //请求用户评论
        NSArray * notes = dict[@"note_list"];
        NSMutableArray * noteArray = [NSMutableArray array];
        for (NSDictionary * note in notes) {
            
            Note * noteModel = [[Note alloc] initWithDic:note];
            [noteArray addObject:noteModel];
        }
        //请求商品信息
        NSDictionary * entity = dict[@"entity"];
        NewProductModel * entityModel = [[NewProductModel alloc] initWithDict:entity];
        NSArray * entityArray = [NSArray arrayWithObject:entityModel];
        if(result){
            result(@[userArray,noteArray,entityArray],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(result){
            result(nil,nil);
        }
    }];
}

#pragma mark 请求日热门，周热门数据
- (void)requestHotEntityDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        NSArray * array = dict[@"content"];
        NSMutableArray * mArray = [NSMutableArray array];
        for (NSDictionary * entityDict in array) {
            NewProductModel * entity = [[NewProductModel alloc] initWithDict:[entityDict objectForKey:@"entity"]];
            [mArray addObject:entity];
        }
        if(result){
            result(mArray,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,error);
        }
    }];
}

#pragma mark 用户-喜欢-最后商品信息
- (void)requestUserLikeEntityDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        Creator * user = [[Creator alloc] initWithDic:dict[@"user"]];
        NewProductModel * entity = [[NewProductModel alloc] initWithDict:dict[@"last_like"]];
        
        NSMutableArray * mArray = [NSMutableArray array];
        [mArray addObject:entity];
        [mArray addObject:user];
        if(result){
            
            result(mArray,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,error);
        }
    }];
}


#pragma mark - 请求其他喜欢商品数据
- (void)requestOtherEntityListDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        NSArray * arrayList = dict[@"entity_list"];
        NSMutableArray * mArray = [NSMutableArray array];
        for (NSDictionary * entityDict in arrayList) {
            NewProductModel * entity = [[NewProductModel alloc] initWithDict:entityDict];
            [mArray addObject:entity];
        }
        if(result){
            result(mArray,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,error);
        }
    }];
}

#pragma mark 请求标签数据
- (void)requestUserTagDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        NSArray * arrayTag = dict[@"tags"];
        NSMutableArray * mArray = [NSMutableArray array];
        for (NSDictionary * tagDict in arrayTag) {
            TagModel * tagModel = [[TagModel alloc] initWithDict:tagDict];
            [mArray addObject:tagModel];
        }
        if(result){
            result(mArray,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,error);
        }
    }];
    
}


#pragma mark - 登录/注册
- (void)requestLoginDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{

    [_manager POST:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary * dict = [ConvertJson ConvertJsonDataToDictionary:responseObject error:nil];
        if(result){
            result(dict,nil);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
        
            result(nil,error);
        }
        
    }];
}

#pragma mark 请求商品分类列表数据 【搜索】
- (void)requestCategoryDataWithURL:(NSString *)url parameters:(id)para result:(void(^)(id data,NSError * error))result{
    
    [_manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * array = [ConvertJson ConvertJsonDataToArray:responseObject error:nil];
        NSMutableArray * mShowEntityArr = [NSMutableArray array];
        for (NSDictionary * entityDict in array) {
            CategoryEntityModel * model = [[CategoryEntityModel alloc] initWithDict:entityDict];
            if(1 == model.status){
                [mShowEntityArr addObject:model];
            }
        }
        if(result){
            result(mShowEntityArr,nil);
        } 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(result){
            result(nil,error);
        }
    }];
    
}



@end
