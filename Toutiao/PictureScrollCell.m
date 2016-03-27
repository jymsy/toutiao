//
//  PictureScrollCell.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/24.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "PictureScrollCell.h"
#import "TTNetworkTools.h"
#import "BannerModel.h"
#import "UIImageView+WebCache.h"

@interface PictureScrollCell() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *pictureScroll;
@property (nonatomic, copy) NSArray *bannerArray;
@property (nonatomic, strong) UIPageControl *pageCtrl;

@end

@implementation PictureScrollCell

- (void)awakeFromNib {
    // Initialization code
    self.pictureScroll.delegate = self;
    CGFloat picSize = SXSCREEN_W * 3;
    //禁止上下拖动
    self.pictureScroll.contentSize = CGSizeMake(picSize, 0);
    //禁止水平越界弹性
    self.pictureScroll.bounces = NO;
    
    self.pageCtrl = [[UIPageControl alloc] init];
    self.pageCtrl.center = CGPointMake(SXSCREEN_W / 2.0, self.pictureScroll.bounds.size.height - 10);
    self.pageCtrl.bounds = CGRectMake(0, 0, 120, 20);
    self.pageCtrl.numberOfPages = 3;
    self.pageCtrl.pageIndicatorTintColor = [UIColor brownColor];
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:self.pageCtrl];
    [self initBannerArray];
}

-(void)initBannerArray {
    //http://api.toutiao.io/v2/banner?app_key=nid5puvc9t0v7hltuy1u&signature=df13d8e3ac9cc1bb117dd033c62734dcd2af1159&timestamp=1458789693
    NSString *url = @"banner";
    [[[TTNetworkTools SharedNetworkTools]GET:url
                                  parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u",
                                                @"signature": @"df13d8e3ac9cc1bb117dd033c62734dcd2af1159",
                                                @"timestamp": @1458789693 }
                                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                                         NSDictionary *banners = responseObject[@"data"];
                                         NSArray *arrayM = [BannerModel objectArrayWithKeyValuesArray:banners];
                                         _bannerArray = [arrayM mutableCopy];
                                         [self prepareBannerImages];
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"%@", error);
                                     }] resume];
}

-(void)prepareBannerImages {
    for (int i=0; i<_bannerArray.count; i++) {
        BannerModel *banner = _bannerArray[i];
        banner.bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(SXSCREEN_W * i, 0, SXSCREEN_W, 200)];
        [banner.bannerView sd_setImageWithURL:[NSURL URLWithString:banner.image] placeholderImage:[UIImage imageNamed:@"avatar"]];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0 + i * SXSCREEN_W, self.pictureScroll.bounds.size.height - 60, SXSCREEN_W - 20, 41)];
        title.text = banner.title;
        title.font = [UIFont systemFontOfSize:15];
        title.numberOfLines= 2;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        
        banner.bannerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapBanner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerTapped:)];
        [banner.bannerView addGestureRecognizer:tapBanner];
        [self.pictureScroll addSubview:banner.bannerView];
        [self.pictureScroll addSubview:title];
    }
}

-(void)bannerTapped:(UIGestureRecognizer *)sender {
    [self.delegate bannerTapped:[self currentArticleId] title:[self currentAriicleTitle]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 用contentOffset来计算当前的页码
    int pageIndex = self.pictureScroll.contentOffset.x/self.pictureScroll.bounds.size.width;
    self.pageCtrl.currentPage = pageIndex;
    
}

-(NSInteger)currentArticleId {
    BannerModel *banner =  _bannerArray[self.pageCtrl.currentPage];
    return [[banner.article objectForKey:@"id"] intValue];
}

-(NSString *)currentAriicleTitle {
    BannerModel *banner =  _bannerArray[self.pageCtrl.currentPage];
    return banner.title;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"end scroll");
}

@end
