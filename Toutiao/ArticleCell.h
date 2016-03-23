//
//  ArticleCell.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/6.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@protocol AvatarTappedDelegate <NSObject>

-(void)avatarTapped:(ArticleModel *)article avatar:(UIImageView *)avatar;

@end

@interface ArticleCell : UITableViewCell

@property (nonatomic, strong) ArticleModel *article;
@property (nonatomic, weak) id<AvatarTappedDelegate> delegate;

@end
