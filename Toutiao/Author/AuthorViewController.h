//
//  AuthorViewController.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/27.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorViewController : UITableViewController

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger following_count;
@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger subjects_count;

@end
