//
//  CONST.h
//  Fruit
//
//  Created by kakaYiGen on 15-4-10.
//  Copyright (c) 2015年 HeKY. All rights reserved.
//

#ifndef Fruit_CONST_h
#define Fruit_CONST_h


//首页 新品推荐 GET
#define URL_NEW_PRODUCTS @"http://api.guoku.com/mobile/v3/entity/?count=30&timestamp=1428625704&rcat=0&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=f57ca532dc23ba1a63abd416989d8732&channel=yingyongbao"
//首页 热品分类 GET
#define URL_HOT_CATEGORY @"http://api.guoku.com/mobile/v3/homepage/?duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=8239ee669003a27837ebff362397426c&channel=yingyongbao"

//商品列表
#define URL_HOT_CATEGORY_LIST @"http://api.guoku.com/mobile/v3/category/%ld/entity/?count=30&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&sort=like&device=Coolpad&os=android_17&offset=0&sign=447f6bc6e999b623d947c7650de00735&reverse=0&channel=yingyongbao"

//商品评论
#define URL_HOT_CATEGORY_NOTE @"http://api.guoku.com/mobile/v3/category/%ld/entity/note/?count=30&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&sort=like&device=Coolpad&os=android_17&offset=0&sign=447f6bc6e999b623d947c7650de00735&reverse=0&channel=yingyongbao"

//商品评论数，喜欢数，商品数
#define URL_HOT_CATEGORY_STAT @"http://api.guoku.com/mobile/v3/category/%ld/stat/?prev=POPULAR_CATEGORY&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=a29779a983aa60e3ab9dfae5633f8fd3&channel=yingyongbao"

#define URL_SHOP_DETAIL_URSER_LIST @"http://api.guoku.com/mobile/v3/entity/%ld/?prev=NOVUS&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=d94d923a22099359479406fadd634222&channel=yingyongbao"

#define URL_SHOP_SIMILARY_ENTITY @"http://api.guoku.com/mobile/v3/entity/guess/?count=30&cid=23&duid=863777024653924&session=f00041b1a705aaf2f75055cb081ac443&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=a5d4e65d32754a28437238574d778cfb&channel=yingyongbao"

//热门【日热门】
#define URL_HOT_DAY_ENTITY @"http://api.guoku.com/mobile/v3/popular/?duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=7f6492ec14ced60803c50be4711ae129&scale=daily&channel=yingyongbao"
//热门【周热门】
#define URL_HOT_WEEKLY_ENTITY @"http://api.guoku.com/mobile/v3/popular/?duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=3800596cb84d1b4322a621d36800ebd1&scale=weekly&channel=yingyongbao"

//用户 【用户信息和最后喜欢】
#define URL_USER_LAST_LIKE @"http://api.guoku.com/mobile/v3/user/%ld/?duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=8239ee669003a27837ebff362397426c&channel=yingyongbao"
//用户 【用户喜欢商品列表】
#define URL_USER_LIKE_LIST @"http://api.guoku.com/mobile/v3/user/%ld/like/?count=30&timestamp=1428889984&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=bf22d1bb2ed05c847575dab31c59a1e9&channel=yingyongbao"
//用户 [点评了]
#define URL_USER_NOTE_ENTITY @"http://api.guoku.com/mobile/v3/user/%ld/entity/note/?count=30&timestamp=1428896573&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=5e86dabf3c5a9d9fbeb5d530a8fd1170&channel=yingyongbao"
//用户标签
#define URL_USER_TAG @"http://api.guoku.com/mobile/v3/user/%ld/tag/?count=100&timestamp=1428906956&duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=703a3143cdbcc500288e6fdaf48b1f08&channel=yingyongbao"
//用户标签 详情
#define URL_USER_TAG_LIST @"http://api.guoku.com/mobile/v3/user/%ld/tag/%@/?duid=863777024653924&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=8239ee669003a27837ebff362397426c&channel=yingyongbao"

//POST
#define URL_USER_REGISTER @"http://api.guoku.com/mobile/v3/register"

//分类列表【搜索】
#define URL_CATEGORY_LIST @"http://api.guoku.com/mobile/v3/category/?duid=863777024653924&session=4252a47d0b55bd756b4af84075b75229&version=3.0&api_key=0b19c2b93687347e95c6b6f5cc91bb87&device=Coolpad&os=android_17&sign=57d62c875695a1d2c42083693d7944ef&channel=yingyongbao"
#endif
