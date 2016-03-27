//
//  BannerModel.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/27.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSDictionary *article;
@property (nonatomic, strong) UIImageView *bannerView;

@end
