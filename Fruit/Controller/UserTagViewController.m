//
//  UserTagViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "UserTagViewController.h"
#import "MyHttpRequest.h"
#import "CONST.h"
#import "NewProductsCell.h"
#import "NewProductModel.h"
#import "ShopDetailViewController.h"
@interface UserTagViewController ()<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UILabel *_lblTitle;
    
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray * _dataArray;
}

@end

@implementation UserTagViewController

#pragma mark 按钮点击事件
- (IBAction)itemBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    _lblTitle.text = self.titleName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NewProductsCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    [self getUserTags];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取数据源

- (void)getUserTags{
    NSString * url = [NSString stringWithFormat:URL_USER_TAG_LIST,self.userId,self.titleName];
    [[MyHttpRequest createInstance] requestOtherEntityListDataWithURL:[url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil result:^(id data, NSError *error) {
        _dataArray = data;
        [_tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewProductsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.products = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NewProductsCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailViewController * shop = [[ShopDetailViewController alloc] init];
    shop.entityID = [_dataArray[indexPath.row] entity_id];
    [self.navigationController pushViewController:shop animated:YES];
    
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
