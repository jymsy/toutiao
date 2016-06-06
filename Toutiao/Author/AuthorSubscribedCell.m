//
//  AuthorSubscribedCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/6/3.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorSubscribedCell.h"
#import "UIImageView+WebCache.h"

@interface AuthorSubscribedCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *authorName;


@end


@implementation AuthorSubscribedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setModel:(AuthorSubscribedModel *)model
{
    _model = model;
    self.name.text = model.name;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar"]] placeholderImage:[UIImage imageNamed:@"avatar"]];
}

@end
