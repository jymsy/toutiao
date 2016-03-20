//
//  MainTabBarController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "MainTabBarController.h"
#import "TabBar.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TabBar *tabBar = [[TabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    [tabBar addBarButton:@"精选"];
    [tabBar addBarButton:@"订阅"];
    [tabBar addBarButton:@"发现"];
    [tabBar addBarButton:@"我的"];
}

@end
