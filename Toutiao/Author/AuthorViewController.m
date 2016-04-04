//
//  AuthorViewController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/27.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorViewController.h"
#import "TTNetworkTools.h"
#import "AuthorModel.h"
#import "AuthorSharesModel.h"
#import "UIImageView+WebCache.h"
#import "AuthorShareCell.h"

@interface AuthorViewController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, copy) NSArray *sharesList;
@property (nonatomic, copy) NSMutableArray *headerLabelList;

@end

@implementation AuthorViewController

-(UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle]loadNibNamed:@"AuthorHeaderView" owner:self options:nil];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(right:)];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:actionBtn, shareBtn, nil];
    
    [self.tableView setTableHeaderView:self.headerView];
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.width / 2.0;
    NSLog(@"%f", self.avatar.layer.cornerRadius);
    self.focusBtn.layer.cornerRadius = self.focusBtn.bounds.size.height / 2.0;
    
    [self loadData];
    __weak AuthorViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadAuthorArticles];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)addHeaderLabel:(NSString *)name {
    if (!_headerLabelList) {
        _headerLabelList = [[NSMutableArray alloc] init];
    }
    [_headerLabelList addObject:name];
}

//举报
-(void)right:(id)sender {
    NSLog(@"right");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)share:(id)sender {
    NSLog(@"share");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadData {
    //users/169571?app_key=nid5puvc9t0v7hltuy1u&signature=7ed2d528bd7e5f7c3f97ae9a6ab69a20cc29a413&timestamp=1459216383
    NSString *url = @"users/169571";
    [[[TTNetworkTools SharedNetworkTools]GET:url
                                  parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u",
                                                @"signature": @"7ed2d528bd7e5f7c3f97ae9a6ab69a20cc29a413",
                                                @"timestamp": @1459216383 }
                                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                                         NSData *author =responseObject[@"data"];
                                         _author = [AuthorModel objectWithKeyValues:author];
                                         [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
                                         [self addHeaderLabel:[NSString stringWithFormat:@"分享  %ld", _author.share_count]];
                                         [self addHeaderLabel:[NSString stringWithFormat:@"主题  %ld", _author.subjects_count]];
                                         [self addHeaderLabel:[NSString stringWithFormat:@"关注  %ld", _author.following_count]];
                                         [self addHeaderLabel:[NSString stringWithFormat:@"关注者  %ld", _author.follower_count]];
                                         _name.text = _author.name;
//                                         [self loadAuthorArticles];
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"%@", error);
                                         [self.tableView.mj_header endRefreshing];
                                     }] resume];
}

-(void)loadAuthorArticles {
    //users/169571/shares?app_key=nid5puvc9t0v7hltuy1u&page=1&page_size=20&signature=228d2a4a6c4a8572a2c1618b4466178b246ebab1&timestamp=1459216383
    NSString *url = @"users/169571/shares";
    [[[TTNetworkTools SharedNetworkTools]GET:url
                                  parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u", @"page":@1, @"page_size":@20,
                                                @"signature": @"228d2a4a6c4a8572a2c1618b4466178b246ebab1",
                                                @"timestamp": @1459216383 }
                                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                                         NSDictionary *shares = responseObject[@"data"];
                                         NSArray *arrayM = [AuthorSharesModel objectArrayWithKeyValuesArray:shares];
                                         _sharesList = [arrayM mutableCopy];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 20)];
//    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    view.layer.borderWidth = 0.3;
    
    CGFloat labelW = SXSCREEN_W / _headerLabelList.count;
    
    for (int i=0; i<_headerLabelList.count; i++) {
        CGFloat labelX = i * labelW;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, labelW, 25)];
        [label setFont:[UIFont systemFontOfSize:12]];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor =[UIColor lightGrayColor].CGColor;
        label.layer.borderWidth = 0.5;
        /* Section header is in 0th index... */
        [label setText:_headerLabelList[i]];
        label.userInteractionEnabled = YES;
        [view addSubview:label];
    }
    
        [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sharesList.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AuthorSharesModel *model = _sharesList[indexPath.row];
    AuthorShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Share" forIndexPath:indexPath];
    cell.model = model;
    return cell;
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
