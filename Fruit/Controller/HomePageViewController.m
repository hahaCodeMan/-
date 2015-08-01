//
//  HomePageViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HomePageViewController.h"
#import "Common.h"
#import "CONST.h"
#import "NewProductModel.h"
#import "NewProductsCell.h"
#import "MyHttpRequest.h"
#import "HomeHeadView.h"
#import "MJRefresh.h"
#import "HotDetailViewController.h"
#import "ShopDetailViewController.h"
#import "WebViewController.h"
#import "HotEntityViewController.h"
#import "RegisterViewController.h"
#import "MBProgressHUD.h"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{

    __weak IBOutlet UITableView *_tableView;
    
    NSMutableArray * _newProducts;
    NSMutableArray * _hots;
    NSInteger _recordCount;
    MBProgressHUD * _hub;
}
@end

@implementation HomePageViewController

//按钮点击事件
- (IBAction)itemBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
            [[self returnAppDelegate].menuController showLeftController:YES];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 下拉上拉刷新

/**
 *  上拉刷新
 */
- (void)upRefresh{
    __weak typeof(self) weakSelf = self;
    [_tableView addLegendFooterWithRefreshingBlock:^{
       
        [weakSelf getNewProductsData];
        
    }];
}

/**
 *  下拉刷新
 */
- (void)downRefresh{

    __weak typeof(self) weakSelf = self;
    [_tableView addLegendHeaderWithRefreshingBlock:^{
       
        _recordCount = 30;
        [weakSelf getNewProductsData];
        
    }];
    
    [_tableView.legendHeader beginRefreshing];
}

#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _recordCount = 30;
    [self upRefresh];
    
//    [self initHub];定制HUB
//    [self downRefresh];
    [self registerClass];
      [_tableView.legendFooter beginRefreshing];
}


- (void)initHub{

    _hub=  [[MBProgressHUD alloc] init];
    _hub.center  = self.view.center;
    _hub.delegate = self;
    _hub.labelText = @"玩命加载中...";
    _hub.labelColor = [UIColor blackColor];
    [self.view.window addSubview:_hub];
    [_hub showWhileExecuting:@selector(getNewProductsData) onTarget:self withObject:nil animated:YES];

}

- (void)hudWasHidden:(MBProgressHUD *)hud{

    [_hub removeFromSuperview];
}

/**
 *  注册Class
 */
- (void)registerClass{

    [_tableView registerNib:[UINib nibWithNibName:@"NewProductsCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    
    _tableView.rowHeight = [NewProductsCell cellHeight];
    HomeHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"HomeHeadView" owner:nil options:0] lastObject];
    headView.callBackURL = ^(NSInteger entityId,NSString * url){
        if(!url){
            ShopDetailViewController * detail = [[ShopDetailViewController alloc] init];
            detail.entityID = entityId;
            [self.navigationController pushViewController:detail animated:YES];
        }else{
            
            WebViewController * web = [[WebViewController alloc] init];
            web.url = url;
            web.titleName = @"专访";
            [self.navigationController pushViewController:web animated:YES];
        }
    };
    headView.clickCallBack = ^(HotCategoryModel * model){
        HotDetailViewController * detail = [[HotDetailViewController alloc] init];
        detail.categroyModel = model;
        [self.navigationController pushViewController:detail animated:YES];
        
    };
    
    headView.callBackTag = ^(NSInteger tag){
        
        if(10001 == tag){
            
            HotEntityViewController * entity = [[HotEntityViewController alloc] init];
            [self.navigationController pushViewController:entity animated:YES];
        }
        
    };
    _tableView.tableHeaderView = headView;
    
}

/**
 *  获取商品数据
 */
- (void)getNewProductsData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyHttpRequest createInstance] requestNewProductsDataWithURL:[NSString stringWithFormat:URL_NEW_PRODUCTS]
                                                       parameters:nil result:^(id data, NSError *error) {
                                                           _newProducts = data;
                                                           [_tableView reloadData];
                                                           [_tableView.legendFooter endRefreshing];
                                                           [_tableView.legendHeader endRefreshing];
                                                           
                                                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                           
                                                       }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewProductsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    cell.products = _newProducts[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clickCallBack = ^(NSString * str){
        NSLog(@"%@",str);
        //弹出登录窗口 【判断是否已经登录】
        [self showLoginView];
    
    };
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [Common createLabelWith:CGRectMake(10, 0, self.view.bounds.size.width, 0) text:@"新品推荐" tag:10000 textColor:nil font:[UIFont systemFontOfSize:13]];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取entityId
    ShopDetailViewController * shop = [[ShopDetailViewController alloc] init];
    NewProductModel * model =  _newProducts[indexPath.row];
    shop.entityID = model.entity_id;
    [self.navigationController pushViewController:shop animated:YES];
    
}
@end
