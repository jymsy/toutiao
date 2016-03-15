//
//  ArticleDetailViewController.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/13.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailModel.h"

@interface ArticleDetailViewController : UITableViewController

@property (nonatomic, assign) NSInteger articleID;
@property (nonatomic, strong) ArticleDetailModel *detailModel;

@end
