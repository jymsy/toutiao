//
//  LatestArticalsTableViewController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/6.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "LatestArticlesViewController.h"
#import "ArticleCell.h"
#import "TTNetworkTools.h"
#import "ArticleModel.h"
#import "ArticleDetailViewController.h"

@interface LatestArticlesViewController ()

@property(nonatomic, strong) NSMutableArray *articleList;

@end

@implementation LatestArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak LatestArticlesViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    //api.toutiao.io/v2/dailies/latest?app_key=nid5puvc9t0v7hltuy1u&signature=2f67b55ef59f99f63b84edff19d875d38069a666&timestamp=1457405182
//    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    NSString *url = @"dailies/latest";
//    [self loadDataForType:1 withURL:allUrlstring];
    [[[TTNetworkTools SharedNetworkTools]GET:url
        parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u",
                           @"signature": @"2f67b55ef59f99f63b84edff19d875d38069a666",
                           @"timestamp": @1457405182 }
    success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(url);
        NSDictionary *articles = responseObject[@"data"][@"article"];
        NSArray *arrayM = [ArticleModel objectArrayWithKeyValuesArray:articles];
        _articleList = [arrayM mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
    }] resume];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleModel *articleModel = self.articleList[indexPath.row];
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
    cell.article = articleModel;
    return cell;
}

#pragma mark - /************************* tbv代理方法 ***************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ArticleDetailViewController class]]) {
        ArticleDetailViewController *advc = segue.destinationViewController;
        NSInteger row = self.tableView.indexPathForSelectedRow.row;
        ArticleModel *model = self.articleList[row];
        advc.articleID = model.id;
    }
}


@end
