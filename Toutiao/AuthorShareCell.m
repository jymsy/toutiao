//
//  AuthorShareCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/4/3.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorShareCell.h"

@interface AuthorShareCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subject;

@end

@implementation AuthorShareCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(AuthorSharesModel *)model {
    _model = model;
    self.title.text = model.title;
    self.likeCount.text = [NSString stringWithFormat:@"%ld", model.like_count];
    self.commentCount.text = [NSString stringWithFormat:@"%ld", model.comment_count];
    self.subject.text = [NSString stringWithFormat:@"来自 %@", model.subject[@"name"]];
}

@end
