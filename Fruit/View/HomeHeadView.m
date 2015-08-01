//
//  HomeHeadView.m
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import "HomeHeadView.h"
#import "Common.h"
#import "HotCategoryModel.h"
#import "UIImageView+AFNetworking.h"
#import "MyHttpRequest.h"
#import "CONST.h"
#define Count 8
@interface HomeHeadView ()<UIScrollViewDelegate>{

    __weak IBOutlet UIScrollView *_bannerView;
    __weak IBOutlet UIPageControl *_pageCtrl;
    __weak IBOutlet UIImageView *_selectionView;
    __weak IBOutlet UIView *_hotRecommend;
    __weak IBOutlet UIImageView *_hotView;
    NSArray * _bannerData;
    NSArray * _hotCategory;
    
}

@end

@implementation HomeHeadView


- (void)awakeFromNib{

    _bannerView.delegate = self;
    [self getHotData];
    [self setHotAndSelectionViewImg];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    _pageCtrl.currentPage = _bannerView.contentOffset.x / _bannerView.bounds.size.width;
}
- (void)getHotData{
    
    [[MyHttpRequest createInstance] requestHotCategoryDataWithURL:URL_HOT_CATEGORY parameters:nil result:^(id data, NSError *error) {
        if(error){
            
            NSLog(@"%@",error.localizedDescription);return;
        }
        [self setHotCategory:[data lastObject]];
        [self setBannerViewContentSize: [data firstObject]];
    }];
    
}
- (void)setHotCategory:(NSArray *)hotCategory{

    _hotCategory = hotCategory;
    for (NSInteger i = 0; i < Count; i++) {
        HotCategoryModel * model = hotCategory[i];
        NSInteger row = i / 4;
        NSInteger col = i % 4;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(5 + 90 * col, 5 + 82 * row, 80, 80)];
        view.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
        view.tag = 10 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapHot:)];
        [view addGestureRecognizer:tap];
        [_hotRecommend addSubview:view];
        UIImageView * imageView = [Common createImageViewWith:CGRectMake(20, 20, 40, 30) image:nil tag:100000 + i isUserInfer:YES];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UILabel * label = [Common  createLabelWith:CGRectMake(0, view.bounds.size.height - 20, 80, 20) text:[Common commonSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"] ForString:model.category_title] tag:10000 + i textColor:nil font:nil];
        label.alpha = 0.5;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:imageView];
        [view addSubview:label];
        if(i == Count - 1){
            imageView.image = [UIImage imageNamed:@"icon_homepage_more"];
            label.text = @"更多品类";
        }else{
            
            [imageView setImageWithURL:[NSURL URLWithString:model.category_icon_small]];
        }
    }
}

- (void)setBannerViewContentSize :(NSArray *) bannerData{
    _bannerData = bannerData;
    _pageCtrl.numberOfPages = bannerData.count;
    _bannerView.contentSize = CGSizeMake(self.bounds.size.width * bannerData.count - 20,0);
    for (NSInteger i = 0; i < bannerData.count; i++) {
        NSDictionary * dict = bannerData[i];
        UIImageView * imageView = [Common createImageViewWith:CGRectMake(i * _bannerView.bounds.size.width, 0, _bannerView.bounds.size.width, _bannerView.bounds.size.height) image:nil tag:1000 + i isUserInfer:YES];
        [imageView setImageWithURL:[NSURL URLWithString:dict[@"img"]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        [imageView addGestureRecognizer:tap];
        [_bannerView addSubview:imageView];
    }
}

- (void)setHotAndSelectionViewImg{

    NSArray * array = @[_selectionView,_hotView];
    NSArray * images = @[@"icon_homepage_selection",@"icon_homepage_hot"];
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIImageView * imageView = (UIImageView *)array[i];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:images[i]];
        imageView.tag = 10000 + i; 
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChooseTap:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)onChooseTap:(UITapGestureRecognizer *)sender{
    if(self.callBackTag){
    
        self.callBackTag(sender.view.tag);
    }
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    
    if(self.callBackURL){
        NSString * string = _bannerData[sender.view.tag - 1000][@"url"];
        if([string hasPrefix:@"http"]){
              self.callBackURL(0,string);
        }else{
         NSArray * array = [string componentsSeparatedByString:@"/"];
            self.callBackURL([[array lastObject] integerValue],nil);
        }
    }
}

- (void)onTapHot:(UITapGestureRecognizer *)sender{
    
    if(self.clickCallBack){
        self.clickCallBack(_hotCategory[sender.view.tag - 10]);
    }
}

+ (CGFloat)headViewHight{

    return 415;
}



@end
