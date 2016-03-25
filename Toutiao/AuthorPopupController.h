//
//  AuthorPopupController.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorPopupController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *popupView;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *name;
@end
