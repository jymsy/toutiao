//
//  ArticleDetailViewController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/13.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "TTNetworkTools.h"
#import "ArticleDetailModel.h"
#import "DetailCell.h"

@interface ArticleDetailViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *subject;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.tableView setTableHeaderView:self.headerView];
}

-(UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle]loadNibNamed:@"DetailHeader" owner:self options:nil];
        
    }
    return _headerView;
}

-(UIWebView *)webView {
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 700)];
        _webView = web;
    }
    return _webView;
}

-(void)setArticleID:(NSInteger)articleID {
    _articleID = articleID;
    NSString *url = @"articles/284118";
    //    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    
    [[TTNetworkTools SharedNetworkTools]GET:url
                                 parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u",
                                               @"signature": @"c5c1829203c9b6bd735e8741b7f2ec9ccd5ff73d",
                                               @"timestamp": @1457710831 }
     success:^(NSURLSessionDataTask *task, id responseObject) {
        self.detailModel = [ArticleDetailModel objectWithKeyValues:responseObject[@"data"]];
         self.subject.text = self.detailModel.subject[@"name"];
        [self showWebView];
//        [self.tableView reloadData];

     } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
    }];
}

-(void)showWebView {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">", self.detailModel.css[0]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:self.detailModel.body];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

-(void)viewWillAppear:(BOOL)animated {
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.height = self.webView.scrollView.contentSize.height;
    NSLog(@"reload %f", self.webView.height);
    [self.tableView reloadData];
}

#pragma mark - 2 cells
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f", self.webView.height);
    return self.webView.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.detailModel == nil) {
        return [UITableViewCell new];
    } else {
        UITableViewCell *cell = [UITableViewCell new];
        [cell.contentView addSubview:self.webView];
        return cell;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
