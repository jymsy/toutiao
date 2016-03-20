//
//  TabBar.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "TabBar.h"
#import "BarButton.h"

@implementation TabBar

-(void)addBarButton:(NSString *)title {
    BarButton *btn = [[BarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
}

-(void)layoutSubviews {
    for (int i=0; i<self.subviews.count; i++) {
        BarButton *btn = self.subviews[i];
        
        CGFloat btnW = SXSCREEN_W/self.subviews.count;
        CGFloat btnH = self.bounds.size.height;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

-(void)btnClick:(BarButton *)btn {
    NSLog(@"click");
}

@end
