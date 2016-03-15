//
//  CommonCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/14.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDetailModel:(ArticleDetailModel *)detailModel {
    _detailModel = detailModel;
}

@end
