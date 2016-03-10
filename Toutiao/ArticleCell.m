//
//  ArticleCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/6.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "ArticleCell.h"

@interface ArticleCell()

@property (weak, nonatomic) IBOutlet UILabel *title;


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
    NSLog(@"%@", self.article.title);
    self.title.text = self.article.title;
}

@end
