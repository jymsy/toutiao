//
//  ArticleDetailModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/12.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDetailModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger like_account;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSDictionary *author_info;
@property (nonatomic, copy) NSArray *css;
@property (nonatomic, copy) NSArray *js;
@property (nonatomic, strong) NSDictionary *subject;
@property (nonatomic, assign) NSInteger create_at;

@end
