//
//  DetailTabBarController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "DetailTabBarController.h"
#import "ArticleDetailViewController.h"
#import "DetaiTabBar.h"

@interface DetailTabBarController ()<DetailTabBarDelegate>

@end

@implementation DetailTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ArticleDetailViewController *advc = [[ArticleDetailViewController alloc] init];
    advc.articleID = self.articleID;
    [self setViewControllers:@[advc]];
    
    DetaiTabBar *tabBar = [[DetaiTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    tabBar.delegate = self;
    
    [tabBar addBarButton:@"返回"];
    [tabBar addBarButton:@"下一篇"];
    [tabBar addBarButton:@"分享"];
    [tabBar addBarButton:@"赞"];
    [tabBar addBarButton:@"评论"];
}

-(void)detailTabClicked:(NSInteger)tag {
    if (tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
