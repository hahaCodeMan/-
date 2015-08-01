//
//  HomeHeadView.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCategoryModel.h"
typedef void(^TopImageClickCb)(HotCategoryModel * cb);
typedef void(^ReturnURLCb)(NSInteger entityId,NSString * url) ;
typedef void(^ReturnTagCb) (NSInteger tag);
@interface HomeHeadView : UIView

+ (CGFloat)headViewHight;
@property (nonatomic,copy)TopImageClickCb clickCallBack;
@property (nonatomic,copy)ReturnURLCb callBackURL;
@property (nonatomic,copy)ReturnTagCb callBackTag;
@end
