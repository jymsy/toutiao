//
//  ArticleCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/6.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "ArticleCell.h"
#import "UIImageView+WebCache.h"

@interface ArticleCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;


@end

@implementation ArticleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArticle:(ArticleModel *)article
{
    _article = article;
    NSLog(@"%ld:%@", self.article.id, self.article.title);
    self.title.text = self.article.title;
    self.subject.text = [NSString stringWithFormat:@"选自 %@", self.article.subject[@"name"]];
    self.likeCount.text = [NSString stringWithFormat:@"%ld", self.article.like_count];
    self.commentCount.text = [NSString stringWithFormat:@"%ld", self.article.comment_count];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.article.user[@"avatar"]] placeholderImage:[UIImage imageNamed:@"avatar"]];
}

@end
