//
//  AuthorPopupController.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthorNameTappedDelegate <NSObject>

@optional
-(void)authorNameTapped:(NSString *) userID;

@end

@interface AuthorPopupController : UIViewController

@property (nonatomic, weak) id<AuthorNameTappedDelegate> delegate;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userID;
@end
