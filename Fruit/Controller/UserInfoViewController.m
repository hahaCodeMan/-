//
//  UserInfoViewController.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-13.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "UserInfoViewController.h"
#import "MyHttpRequest.h"
#import "CONST.h"
#import "NewProductModel.h"
#import "Creator.h"
#import "EntityCell.h"
#import "NoteCell.h"
#import "TagCell.h"
#import "UIImageView+AFNetworking.h"
#import "ShopDetailViewController.h"
#import "UserTagViewController.h"
@interface UserInfoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UIImageView *_userImage;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblAttention;
    __weak IBOutlet UILabel *_lblFuns;
    __weak IBOutlet UIView *_btnView;
    __weak IBOutlet UILabel *_lblLike;
    __weak IBOutlet UILabel *_lblMark;
    __weak IBOutlet UILabel *_lblNote;
    __weak IBOutlet UICollectionView *_collectionView;
    
    UIView * _view;
    NewProductModel * _lastEntity;
    NSMutableArray * _otherEntityList;
    NSMutableArray * _arrayNotes;
    NSMutableArray * _userTags;
    UITableView * _tableView;
    BOOL _isTag;
}

@end

@implementation UserInfoViewController

#pragma mark 设置状态，添加手势
-  (void)setSelectedStatus{
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, _btnView.bounds.size.height - 2, _btnView.bounds.size.width / 3, 2)];
    _view.backgroundColor = [UIColor blueColor];
    [_btnView addSubview:_view];
    
    for (UIView * view in _btnView.subviews) {
        if([view isKindOfClass:[UILabel class]]){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            [view addGestureRecognizer:tap];
        }
    }
}

- (void)onTap:(UIGestureRecognizer*)sender{
    [self removeStatus:sender.view];
    
    switch (sender.view.tag) {
        case 201:
            _isTag = NO;
            [self.view bringSubviewToFront:_collectionView];
            break;
        case 202:
            _isTag = NO;
            [self.view bringSubviewToFront:_tableView];
            [_tableView reloadData];
            break;
        case 203:
            _isTag = YES;
            [self.view bringSubviewToFront:_tableView];
            [_tableView reloadData];
            break;
        default:
            break;
    }
    
}

#pragma mark 重置状态
- (void)removeStatus:(UIView *)sender{
    
    CGRect frame = _view.frame;
    
    frame.origin.x = sender.frame.origin.x;
    
    _view.frame = frame;
    
}

- (IBAction)itemBtnClick:(UIButton *)sender {
    
    if(100 == sender.tag){
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 生命周期函数
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    if(_isTag){
        [self.view bringSubviewToFront: _tableView];
    }else{
        [self.view bringSubviewToFront: _collectionView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _arrayNotes = [NSMutableArray array];
    [self initLayout];//初始化布局，collectionView
    [self initTableView];//初始化tableView
    [self setSelectedStatus];//设置状态
    [self getUserAndLastLikeData];//获取用户数据
    [self getuserOtherLikeData];//获取collectionView的数据
    [self getUserNoteEntityData];
    [self getUserTagData];
}

#pragma mark - 初始化控件方法
/**
 *  初始化CollectionViewLayout
 */
- (void)initLayout{

    [_collectionView registerNib:[UINib nibWithNibName:@"EntityCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake(110, 110);
    layout.minimumInteritemSpacing = 10.0f;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [_collectionView setCollectionViewLayout:layout];
    
}

/**
 *  初始化tableView
 */
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:_collectionView.frame style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TagCell" bundle:nil] forCellReuseIdentifier:@"tagCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NoteCell" bundle:nil] forCellReuseIdentifier:@"noteCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    }

#pragma mark - 获取数据源
#pragma mark 获取用户和最后喜欢商品信息
- (void)getUserAndLastLikeData{

    [[MyHttpRequest createInstance] requestUserLikeEntityDataWithURL:[NSString stringWithFormat:URL_USER_LAST_LIKE,self.userId] parameters:nil result:^(id data, NSError *error) {
        _lastEntity = [data firstObject];
        [self setUserInfo:[data lastObject]];
    }];
}

#pragma mark 获取用户喜欢的商品列表
- (void)getuserOtherLikeData{

    [[MyHttpRequest createInstance] requestOtherEntityListDataWithURL:[NSString stringWithFormat:URL_USER_LIKE_LIST,self.userId] parameters:nil result:^(id data, NSError *error) {
        _otherEntityList = data;
        if(_lastEntity !=nil){
            [_otherEntityList addObject:_lastEntity];
        }
        [_collectionView reloadData];
    }];
}
#pragma mark 获取用户评论过的信息
- (void)getUserNoteEntityData{

    [[MyHttpRequest createInstance] requestCategoryNoteDataWithURL:[NSString stringWithFormat:URL_USER_NOTE_ENTITY,self.userId] parameters:nil result:^(id data, NSError *error) {
        _arrayNotes = data;
        [_tableView reloadData];
        
    }];
}

#pragma mark 获取用户标签数据
- (void)getUserTagData{
    [[MyHttpRequest createInstance] requestUserTagDataWithURL:[NSString stringWithFormat:URL_USER_TAG,self.userId] parameters:nil result:^(id data, NSError *error) {
        _userTags = data;
        [_tableView reloadData];
    }];
}

#pragma mark 设置用户信息
/**
 *  设置用户信息
 *
 *  @param userModel 数据源
 */
- (void)setUserInfo:(Creator *)userModel{
    [_userImage setImageWithURL:[NSURL URLWithString:userModel.avatar_small]];
    NSMutableString * string = [NSMutableString stringWithString:userModel.nickname];
    if([userModel.gender isEqualToString:@"O"]){
        [string appendString:@" ♂"];
    }else{
        [string appendString:@" ♀"];
    }
    _lblName.text = string;
    _lblAttention.text = [NSString stringWithFormat:@"%ld关注",userModel.following_count];
    _lblFuns.text = [NSString stringWithFormat:@"%ld粉丝",userModel.fan_count];
    _lblLike.text = [NSString stringWithFormat:@"喜爱 %ld",userModel.like_count];
    _lblNote.text = [NSString stringWithFormat:@"点评 %ld",userModel.entity_note_count];
    _lblMark.text = [NSString stringWithFormat:@"标签 %ld",userModel.tag_count];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _otherEntityList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    EntityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.entity = _otherEntityList[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ShopDetailViewController * shop = [[ShopDetailViewController alloc] init];
    NewProductModel * model = _otherEntityList[indexPath.row];
    shop.entityID = model.entity_id;
    [self.navigationController pushViewController:shop animated:YES];
    
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(_isTag){
    
        return _userTags.count;
    }
    return [[_arrayNotes firstObject] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_isTag){
        TagCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell"];
        cell.tagModel = _userTags[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        NoteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.noteModel = [_arrayNotes firstObject] [indexPath.row];
        cell.entityModel = [_arrayNotes lastObject][indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_isTag){
        
        TagCell * cell = (TagCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    NoteCell * cell = (NoteCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_isTag){
    
        UserTagViewController * user = [[UserTagViewController alloc] init];
        user.userId = self.userId;
        TagModel * tagModel = _userTags[indexPath.row];
        user.titleName = tagModel.tag;
        [self.navigationController pushViewController:user animated:YES];
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
