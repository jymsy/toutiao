//
//  DetaiTabBar.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "DetaiTabBar.h"

@implementation DetaiTabBar

-(void)addBarButton:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self addSubview:btn];

}

-(void)layoutSubviews {
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat btnW = SXSCREEN_W/self.subviews.count;
        CGFloat btnH = self.bounds.size.height;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

-(void)btnClick:(UIButton *)btn {
    NSLog(@"click");
    if ([self.delegate respondsToSelector:@selector(detailTabClicked:)]) {
        [self.delegate detailTabClicked:btn.tag];
    }
}

@end
