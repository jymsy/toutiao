//
//  BarButton.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "BarButton.h"

@implementation BarButton

-(void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
//    self.titleLabel.x = 0;
//    self.titleLabel.y = 0;
//    self.titleLabel.shadowColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

@end
