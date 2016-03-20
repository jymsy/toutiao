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
#import "DetailTabBarController.h"

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
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
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

-(void)loadMoreData {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ArticleDetailViewController *advc = [[UIStoryboard storyboardWithName:@"ArticleDetail" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//    DetailTabBarController *advc = [[UIStoryboard storyboardWithName:@"ArticleDetail" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    DetailTabBarController *advc = [[DetailTabBarController alloc]init];
    
    ArticleModel *model = self.articleList[indexPath.row];
//    advc.articleID = model.id;
    advc.navigationItem.title = model.title;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [advc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:advc animated:YES];
    
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
        advc.navigationItem.title = model.title;
        
        
    }
}


@end
