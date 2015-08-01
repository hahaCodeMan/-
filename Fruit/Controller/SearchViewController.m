//
//  SearchViewController.m
//  Fruit
//
//  Created by ； on 15-4-14.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "SearchViewController.h"
#import "MyHttpRequest.h"
#import "CONST.h"
#import "CategoryEntityModel.h"
#import "CategoryMdodel.h"
#import "CategoryCell.h"
#import "Common.h"
#import "CategoryReusableView.h"
#import "HotDetailViewController.h"
#import "SearchGroupViewController.h"
#import "MBProgressHUD.h"
@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    NSMutableArray * _mDataArray;
    NSMutableArray * _msubArray;
    NSMutableArray * _totalsStatus1;
    NSMutableArray * _totalsStatus0;
    __weak IBOutlet UITextField *_txtInput;
    __weak IBOutlet UICollectionView *_collectionView;

}

@end

@implementation SearchViewController
- (IBAction)itemBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            //导航按钮
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 101:{
            //确定查找
            
        }
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initlayout];
    [self  getCategoryList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 初始化item布局
/**
 *  初始化Layout
 */
- (void)initlayout{

    _totalsStatus1 = [NSMutableArray array];
    _totalsStatus0 = [NSMutableArray array];
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    
    //注册SectionView
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myView"];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.minimumInteritemSpacing = 10.0f;
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [_collectionView setCollectionViewLayout:layout];
    
}

#pragma mark 获取数据源
- (void)getCategoryList{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyHttpRequest createInstance] requestCategoryDataWithURL:URL_CATEGORY_LIST parameters:nil result:^(id data, NSError *error) {
        _mDataArray = data;
        [_collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return _mDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CategoryEntityModel * model =_mDataArray[section];
    NSArray * array = model.content;
    return [self calcSectionItemCount:array];
}

- (NSInteger )calcSectionItemCount:(NSArray *)array{

    NSMutableArray * arrays = [NSMutableArray array];
    NSMutableArray * arrays0 = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        CategoryMdodel * model = [[CategoryMdodel alloc] initWithDict:dict];
        if(1 == model.status) [arrays addObject:model];
        else [arrays0 addObject:model];
    }
    [_totalsStatus1 addObject:arrays];
    [_totalsStatus0 addObject:arrays0];
    return arrays.count;
    
}

//设置单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.model = _totalsStatus1[indexPath.section][indexPath.row];
    return cell;
}

//添加sectionView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CategoryReusableView * myView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myView" forIndexPath:indexPath];
        myView.indexPath = indexPath;
        myView.clickCb = ^(NSIndexPath * noPath){
            SearchGroupViewController *searchGroup = [[SearchGroupViewController alloc] init];
            searchGroup.entityModel = _mDataArray[noPath.section];
            searchGroup.dataArray = @[_totalsStatus1[noPath.section],_totalsStatus0[noPath.section]];
            [self.navigationController pushViewController:searchGroup animated:YES];
        };
        
        myView.model = _mDataArray[indexPath.section];
        return myView;
    }else return nil;
    
}
//设置头区域的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [CategoryReusableView sectionHigth];
}

//item选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    HotDetailViewController * hot = [[HotDetailViewController alloc] init];
    hot.categroyModel =  _totalsStatus1[indexPath.section][indexPath.row];
    [self.navigationController  pushViewController:hot animated:YES];

}

@end
