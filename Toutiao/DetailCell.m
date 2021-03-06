//
//  DetailCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/14.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell()
@property (weak, nonatomic) IBOutlet UILabel *from;

@end

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDetailModel:(ArticleDetailModel *)detailModel {
    [super setDetailModel:detailModel];
    self.from.text = self.detailModel.subject[@"name"];
    
}

@end
