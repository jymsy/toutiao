//
//  ResponseModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/9.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *pre_date;
@property (nonatomic, copy) NSString *next_date;
@property (nonatomic, assign) BOOL is_today;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, strong) NSArray *article;

@end
