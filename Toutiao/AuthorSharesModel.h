//
//  AuthorSharesModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/4/3.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorSharesModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger posted_id;
@property (nonatomic, copy) NSString *original_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) NSDictionary *subject;
@property (nonatomic, assign) NSInteger created_at;

@end
