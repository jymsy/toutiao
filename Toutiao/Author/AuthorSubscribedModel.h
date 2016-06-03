//
//  AuthorSubscribedModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/4/26.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorSubscribedModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger post_count;
@property (nonatomic, assign) NSInteger subscriber_count;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, assign) NSInteger created_at;
@property (nonatomic, assign) BOOL subscribed;

@end
