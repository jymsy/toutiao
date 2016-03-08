//
//  TTNetworkTools.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/8.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TTNetworkTools : AFHTTPSessionManager

+(instancetype)SharedNetworkTools;

@end
