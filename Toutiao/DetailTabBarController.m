//
//  DetailTabBarController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "DetailTabBarController.h"
#import "ArticleDetailViewController.h"

@interface DetailTabBarController ()

@end

@implementation DetailTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ArticleDetailViewController *advc = [[ArticleDetailViewController alloc] init];
    advc.articleID = self.articleID;
    [self setViewControllers:@[advc]];
}


@end
