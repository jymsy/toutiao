//
//  AuthorModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/4/3.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *github;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger following_count;
@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger subjects_count;
@end
