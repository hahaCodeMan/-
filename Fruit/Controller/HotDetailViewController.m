//
//  HotDetailViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HotDetailViewController.h"
#import "CONST.h"
#import "MyHttpRequest.h"
#import "HotCategoryStat.h"
#import "HotCategoryModel.h"
#import "Note.h"
#import "NewProductsCell.h"
#import "NoteCell.h"
#import "ShopDetailViewController.h"
#import "MBProgressHUD.h"
#import "SortView.h"
#define OneCell @"OneCell"
#define TwoCell @"TwoCell"
@interface HotDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{


    __weak IBOutlet UILabel *_lblTitle;
    
    __weak IBOutlet UIView *_BtnView;
    __weak IBOutlet UILabel *_lblshop;
    __weak IBOutlet UILabel *_lblrecommend;
    __weak IBOutlet UILabel *_lblFavorite;
    __weak IBOutlet UITableView *_tableView;
    
   
    UIView * _view;
    SortView *_sortView;
    NSMutableArray * _dataArray;
    NSString * _cellIdentifier;
    NSMutableArray * _entityArray;
    NSMutableArray * _noteArray;
    BOOL _isEntity;
}

@end

@implementation HotDetailViewController

- (IBAction)itemBtnClick:(UIButton *)sender {
    
    
    if(10 == sender.tag){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        _sortView.hidden =!_sortView.hidden;
    }
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    
    _lblTitle.text = self.categroyModel.category_title;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedStatus];
    [self getCategoryStatData];
    [self getCategoryListData];
    [self getCategoryNoteData];
    [self initSortView];
    
    _isEntity = YES;
}


#pragma mark 初始化排序视图
/**
 *  初始化排序方法
 */
- (void)initSortView{
    _sortView = [[[NSBundle mainBundle] loadNibNamed:@"SortView" owner:self options:0] lastObject];
    __weak typeof (self)weakSelf = self;
    _sortView.returnFlg = ^(NSInteger flg){
        //100 按价格升序
        if(100 == flg){
            
             [weakSelf sortMethod:YES];
        }else{
             [weakSelf sortMethod:NO];
        }
    };
    _sortView.frame = CGRectMake(295, 64, 80, 80);
    [self.view addSubview:_sortView];
    _sortView.hidden = YES;
}


- (void)sortMethod:(BOOL )isDesc{
    
    NSArray *array;
    if(isDesc){
        array = [_dataArray sortedArrayUsingComparator:^NSComparisonResult(NewProductModel * obj1, NewProductModel * obj2) {
            if([obj1.price integerValue] > [obj2.price integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }else if([obj1.price integerValue] < [obj2.price integerValue]){
                return (NSComparisonResult)NSOrderedDescending;
            }else{
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
    }else{
        array = [_dataArray sortedArrayUsingComparator:^NSComparisonResult(NewProductModel * obj1, NewProductModel * obj2) {
            if([obj1.price integerValue] < [obj2.price integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }else if([obj1.price integerValue] > [obj2.price integerValue]){
                return (NSComparisonResult)NSOrderedDescending;
            }else{
                return (NSComparisonResult)NSOrderedSame;
            }
            
        }];
    }
    _dataArray = (NSMutableArray *)array;
    [_tableView reloadData];
    
}



#pragma mark 设置商品数，点评数，喜爱数
/**
 *  设置商品数，点评数，喜爱数
 */
- (void)getCategoryStatData{

    [[MyHttpRequest createInstance] requestCategoryStatDataWithURL:[NSString stringWithFormat:URL_HOT_CATEGORY_STAT,self.categroyModel.category_id]parameters:nil result:^(id data, NSError *error) {
        HotCategoryStat * stat = data;
        _lblshop.text = [NSString stringWithFormat:@"商品%ld",stat.entity_count];
        _lblrecommend.text = [NSString stringWithFormat:@"点评%ld",stat.entity_note_count];
        _lblFavorite.text = [NSString stringWithFormat:@"喜爱%ld",stat.like_count];
        
    }];
}

- (void)getCategoryListData{

    [_dataArray removeAllObjects];
    _cellIdentifier = @"OneCell";
     [_tableView registerNib:[UINib nibWithNibName:@"NewProductsCell" bundle:nil] forCellReuseIdentifier:OneCell];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyHttpRequest createInstance] requestNewProductsDataWithURL:[NSString stringWithFormat:URL_HOT_CATEGORY_LIST,self.categroyModel.category_id] parameters:nil result:^(id data, NSError *error) {
        _dataArray = data;
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (void)getCategoryNoteData{

     _cellIdentifier = @"TwoCell";
    [_tableView registerNib:[UINib nibWithNibName:@"NoteCell" bundle:nil] forCellReuseIdentifier:TwoCell];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyHttpRequest createInstance] requestCategoryNoteDataWithURL:[NSString stringWithFormat:URL_HOT_CATEGORY_NOTE,self.categroyModel.category_id] parameters:nil result:^(id data, NSError *error) {
        _noteArray = [data firstObject];
        _entityArray = [data lastObject];
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


#pragma mark 设置状态，添加手势
-  (void)setSelectedStatus{

    _view = [[UIView alloc] initWithFrame:CGRectMake(0, _BtnView.bounds.size.height - 2, _BtnView.bounds.size.width / 3, 2)];
    _view.backgroundColor = [UIColor blueColor];
    [_BtnView addSubview:_view];
    
    for (UIView * view in _BtnView.subviews) {
        if([view isKindOfClass:[UILabel class]]){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            [view addGestureRecognizer:tap];
        }
    }
}

#pragma mark 重置状态
- (void)removeStatus:(UIView *)sender{

    CGRect frame = _view.frame;
    frame.origin.x = sender.frame.origin.x;
    _view.frame = frame;
 
}
#pragma mark 点击手势事件
- (void)onTap:(UITapGestureRecognizer *)sender{
    [self removeStatus:sender.view];
    
    switch (sender.view.tag) {
        case 100:
            _isEntity = YES;
            [_tableView reloadData];
            break;
        case 101:
            _isEntity = NO;
            _sortView.hidden = YES;
            [_tableView reloadData];
            break;
        case 102:{
            //喜爱
            _sortView.hidden = YES;
        }
            break;
        default:
            break;
    }
    

}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(_isEntity)return _dataArray.count;
    return _noteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_isEntity){
        NewProductsCell * cell = [tableView dequeueReusableCellWithIdentifier:OneCell];
        cell.products = _dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    
        NoteCell * cell = [tableView dequeueReusableCellWithIdentifier:TwoCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.noteModel = _noteArray [indexPath.row];
        cell.entityModel = _entityArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isEntity) return [NewProductsCell cellHeight];
    NoteCell * cell = (NoteCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_isEntity){
    
        NewProductModel * model = _dataArray[indexPath.row];
        ShopDetailViewController * detail = [[ShopDetailViewController alloc] init];
        detail.entityID = model.entity_id;
        detail.categoryID = model.category_id;
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
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
