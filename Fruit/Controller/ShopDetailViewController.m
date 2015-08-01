//
//  ShopDetailViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-11.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "MyHttpRequest.h"
#import "CONST.h"
#import "Common.h"
#import "Creator.h"
#import "NewProductModel.h"
#import "Note.h"
#import "ShopDetailHeadView.h"
#import "ShopDetailFootView.h"
#import "ShopDetailCell.h"
#import <ShareSDK/ShareSDK.h>
#import "UMSocial.h"
#import "UserInfoViewController.h"
#import "WebViewController.h"
#define kUmengSDKAppKey @"552a1692fd98c51dbe00102f"
@interface ShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{


    __weak IBOutlet UITableView *_tableView;
 
    NSMutableArray * _mDataArray;
    
    NewProductModel * _entityModel;
}

@end

@implementation ShopDetailViewController

#pragma mark - 导航按钮点击事件
- (IBAction)itemBtnClick:(UIButton *)sender {

    switch (sender.tag) {
        case 100:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 101:{
            //分享内容到微博
            [self share];
        }
            break;
        default:
            break;
    }
    
}


- (void)share{

    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUmengSDKAppKey
                                      shareText:_entityModel.title
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_entityModel.chief_image]]]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,nil]
                                       delegate:nil];
}

#pragma mark - 获取数据源

/**
 *  获取用户列表数据
 */
- (void)getLikeUserList{

    //加载头部视图
    ShopDetailHeadView * headView = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailHeadView" owner:self options:nil] lastObject];
    
    headView.userIDCb = ^(NSInteger userId){
        //点击用户头像进入用户信息界面
        UserInfoViewController * user = [[UserInfoViewController alloc] init];
        user.userId = userId;
        [self.navigationController pushViewController:user animated:YES];
        
    };
    
    headView.entityLink = ^(NSString * entityLink){
    
        WebViewController * web = [[WebViewController alloc] init];
        web.url = entityLink;
        web.titleName = @"果库";
        [self.navigationController  pushViewController:web animated:YES];
        
    };
    
    //加载单元格
    [_tableView registerNib:[UINib nibWithNibName:@"ShopDetailCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    
    _tableView.tableHeaderView = headView;
    [[MyHttpRequest createInstance] requestLikeUserListDataWithURL: [NSString stringWithFormat:URL_SHOP_DETAIL_URSER_LIST,self.entityID] parameters:nil result:^(id data, NSError *error) {
        headView.dataArray = @[[data lastObject],[data firstObject]];
        [_mDataArray arrayByAddingObjectsFromArray:data[1]];
        _entityModel =[data lastObject][0];
        [_tableView reloadData];
    }];
    
}

/**
 *  获取相似推荐数据
 */
- (void)getSimilarityEntity{

    //加载底部视图
    ShopDetailFootView * footView = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailFootView" owner:self options:nil] lastObject];
    footView.cb = ^(NSString * string){
        if(string.length >3 ){
            ShopDetailViewController * shop = [[ShopDetailViewController alloc] init];
            shop.entityID = [string integerValue];
            [self.navigationController pushViewController:shop animated:YES];
        }else{
#warning 写评论 需登录

        }
        NSLog(@"====>%@======",string);
    };
    
    _tableView.tableFooterView = footView;
    [[MyHttpRequest createInstance] requestNewProductsDataWithURL:[NSString stringWithFormat:URL_SHOP_SIMILARY_ENTITY,self.categoryID] parameters:nil result:^(id data, NSError *error) {
        
        if(error){
        
            NSLog(@"%@",error.localizedDescription);
        }
        footView.entitys = data;
        
    }];
    
}


#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mDataArray = [NSMutableArray array];
    [self getLikeUserList];//获取喜欢该商品的用户列表
    [self getSimilarityEntity];//获取相似商品
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _mDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShopDetailCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"MyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.note = _mDataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailCell * cell = (ShopDetailCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
