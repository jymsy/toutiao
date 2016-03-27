//
//  PictureScrollCell.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/24.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerTappedDelegate <NSObject>

-(void) bannerTapped:(NSInteger)articleId title:(NSString *)title;

@end

@interface PictureScrollCell : UITableViewCell

-(NSInteger)currentArticleId;
-(NSString *)currentAriicleTitle;
@property (nonatomic, weak)id<BannerTappedDelegate> delegate;

@end
