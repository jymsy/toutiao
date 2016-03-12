//
//  ArticleModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/9.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, assign) BOOL is_advertorial;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contributor;
@property (nonatomic, copy) NSString *original_site_name;
@property (nonatomic, assign) BOOL is_recommend;
@property (nonatomic, copy) NSString *original_url;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) NSDictionary *subject;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSDictionary *author_info;
@property (nonatomic, assign) NSInteger created_at;

@end
