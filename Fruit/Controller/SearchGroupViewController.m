//
//  SearchGroupViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-15.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "SearchGroupViewController.h"
#import "Common.h"
#import "CategoryCell.h"
#import "CategoryCommonCell.h"
#import "CategoryReusableView.h"
#import "HotDetailViewController.h"
@interface SearchGroupViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{


    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UICollectionView *_collectionView;
    
}

@end

@implementation SearchGroupViewController

- (IBAction)itemBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化方法
#pragma mark 初始化item布局
/**
 *  初始化Layout
 */
- (void)initlayout{
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCommonCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
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

#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    
    NSString * string = [Common commonSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"] ForString:self.entityModel.title];
    _lblTitle.text = [NSString stringWithFormat:@"%@ %@ %@",@"[",string,@"]"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initlayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if(0 == indexPath.section){
        CategoryCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
        CategoryMdodel * model = _dataArray[indexPath.section][indexPath.row];
        cell.model = model;
        return cell;
    }else{
        
        CategoryCommonCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        CategoryMdodel * model = _dataArray[indexPath.section][indexPath.row];
        cell.titleName = model.category_title;
        return cell;
    }
}
//设置头区域的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [CategoryReusableView sectionHigth];
}

//添加sectionView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CategoryReusableView * myView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myView" forIndexPath:indexPath];
        
        [myView.subviews enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL *stop) {
            if([obj isMemberOfClass:[UIImageView class]]){
                obj.hidden = YES;
                *stop = YES;
            }
        }];
        
        if(0 == indexPath.section) myView.lblTitle.text = @"优选品类";
        else myView.lblTitle.text = @"普通品类";
       
        return myView;
    }else return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HotDetailViewController * hot = [[HotDetailViewController alloc] init];
    hot.categroyModel =  _dataArray[indexPath.section][indexPath.row];
    [self.navigationController  pushViewController:hot animated:YES];
}


@end
