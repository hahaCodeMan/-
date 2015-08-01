//
//  HotEntityViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-12.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HotEntityViewController.h"
#import "Common.h"
#import "CONST.h"
#import "MyHttpRequest.h"
#import "NewProductModel.h"
#import "HotDayCell.h"
#import "ShopDetailViewController.h"
#define ItemHeight 160
#define ItemWidth 160
@interface HotEntityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    __weak IBOutlet UILabel *_lblDayHot;
    __weak IBOutlet UILabel *_lblWeekHot;
    __weak IBOutlet UIView *_btnView;
    __weak IBOutlet UICollectionView *_collectionView;
    
    NSMutableArray * _dayDataArray;
    NSMutableArray * _weekDataArray;
    BOOL _isWeek;
    UIView *_view;
}
@end

@implementation HotEntityViewController

#pragma mark - 设置选择按钮状态
#pragma mark 设置状态，添加手势
-  (void)setSelectedStatus{
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, _btnView.bounds.size.height - 2, _btnView.bounds.size.width / 2, 2)];
    _view.backgroundColor = [UIColor blueColor];
    [_btnView addSubview:_view];
    
    for (UIView * view in _btnView.subviews) {
        if([view isKindOfClass:[UILabel class]]){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            [view addGestureRecognizer:tap];
        }
    }
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    [self removeStatus:sender.view];
    
    if(100 == sender.view.tag){
        
        _isWeek = NO;
    }else{
        
        _isWeek = YES;
    }
    [_collectionView reloadData];
}
#pragma mark 重置状态
- (void)removeStatus:(UIView *)sender{
    
    CGRect frame = _view.frame;
    
    frame.origin.x = sender.frame.origin.x;
    
    _view.frame = frame;
    
}
- (IBAction)itemBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark - 获取数据源

- (void)getHotEntityDay{
    
    [[MyHttpRequest createInstance] requestHotEntityDataWithURL:URL_HOT_DAY_ENTITY parameters:nil result:^(id data, NSError *error) {
        _dayDataArray = data;
        [_collectionView reloadData];
    }];
}

- (void)getHotEntityWeek{
    [[MyHttpRequest createInstance] requestHotEntityDataWithURL:URL_HOT_WEEKLY_ENTITY parameters:nil result:^(id data, NSError *error) {
        _weekDataArray = data;
    }];
}
#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
        _isWeek = NO;
    // Do any additional setup after loading the view from its nib.
    [self setCollectionViewLayout];
    [self getHotEntityDay];
    [self getHotEntityWeek];
    
}

- (void)setCollectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"HotDayCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    [self setSelectedStatus];
    [_collectionView setCollectionViewLayout:layout];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(_isWeek){
    
        return _weekDataArray.count;
    }
    
    return _dayDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HotDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    if(_isWeek){
        cell.entity = _weekDataArray[indexPath.row];
    }
    else{
        cell.entity = _dayDataArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopDetailViewController * shop = [[ShopDetailViewController alloc] init];
    if(_isWeek){
        shop.entityID = [_weekDataArray[indexPath.row] entity_id];
        
    }else{
        shop.entityID = [_dayDataArray[indexPath.row] entity_id];
    }
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
