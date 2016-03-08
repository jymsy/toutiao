//
//  TTNetworkTools.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/8.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "TTNetworkTools.h"

@implementation TTNetworkTools

+(instancetype)SharedNetworkTools
{
    static TTNetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL ];
    });
    return self;
}

@end
