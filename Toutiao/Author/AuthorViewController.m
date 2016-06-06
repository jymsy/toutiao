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
#import "AuthorSubscribedCell.h"
#import "AuthorSubscribedModel.h"

@interface AuthorViewController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, strong) NSMutableArray *sharesList;
@property (nonatomic, strong) NSMutableArray *subscribedList;
@property (nonatomic, strong) NSMutableArray *headerLabelList;
//section header label view
@property (nonatomic, strong) UIView *headerLabelView;
//当前的label index
@property (nonatomic, assign) NSUInteger labelIndex;
//当前页数
@property (nonatomic, assign) NSNumber *currentPage;

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
    
    _labelIndex = 0;
    _currentPage = @1;
    
    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(right:)];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:actionBtn, shareBtn, nil];
    
    [self.tableView setTableHeaderView:self.headerView];
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.width / 2.0;
    self.focusBtn.layer.cornerRadius = self.focusBtn.bounds.size.height / 2.0;
    
    [self loadAuthorDetail];
    __weak AuthorViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAuthorArticles)];

//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadAuthorArticles];
//    }];
    
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

-(void)loadAuthorDetail {
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
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"%@", error);
                                         [self.tableView.mj_header endRefreshing];
                                     }] resume];
}

-(void)loadAuthorArticles {
    //users/169571/shares?app_key=nid5puvc9t0v7hltuy1u&page=1&page_size=20&signature=228d2a4a6c4a8572a2c1618b4466178b246ebab1&timestamp=1459216383
    NSString *url;
    NSString *sig;
    NSNumber *timestamp = 0;
    //分享
    if (_labelIndex == 0) {
        url = @"users/169571/shares";
        sig = @"228d2a4a6c4a8572a2c1618b4466178b246ebab1";
        timestamp = @1459216383;
    } else if (_labelIndex == 1) {//主题
        url = @"users/136152/subscribed_subjects";
        sig = @"bcba889751f73a3303f242d237263678ffdf828a";
        timestamp = @1461640751;
    } else if (_labelIndex == 2) {//关注
        
    } else if (_labelIndex == 3) {//关注者
        
    }
    
    [self loadDataForType:1 url:url sig:sig timestamp:timestamp];
}

-(void)loadDataForType:(int)type url:(NSString *)url sig:(NSString *)sig timestamp:(NSNumber *)timestamp{
    NSNumber *page;
    if (type == 1) {
        //下拉
        page = [NSNumber numberWithInt:1];
    } else {
        //上拉
        page = _currentPage = [NSNumber numberWithInt:[_currentPage intValue] + 1];
    }
    
    [[[TTNetworkTools SharedNetworkTools] GET:url
                                  parameters:@{ @"app_key": @"nid5puvc9t0v7hltuy1u", @"page":page , @"page_size":@20,
                                                @"signature": sig,
                                                @"timestamp": timestamp }
                                     success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                                         NSDictionary *shares = responseObject[@"data"];
                                         
                                         NSArray *arrayM = [self transformResponseData:shares];
                                         
                                         if (type == 1) {
                                             _sharesList = [arrayM mutableCopy];
                                             [self.tableView.mj_header endRefreshing];
                                         } else {
                                             [_sharesList addObjectsFromArray:arrayM];
                                             [self.tableView.mj_footer endRefreshing];
                                         }
                                         [self.tableView reloadData];
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"%@", error);
                                     }] resume];
}

-(NSArray *)transformResponseData:(NSDictionary *)data
{
    if (_labelIndex == 0) {
        return [AuthorSharesModel objectArrayWithKeyValuesArray:data];
    } else if (_labelIndex == 1) {
        return [AuthorSubscribedModel objectArrayWithKeyValuesArray:data];
    }
    return @[];
}

-(void)loadMoreData {
    NSString *sig;
    NSNumber *timestamp = 0;
    NSString *url = @"users/169571/shares";
    sig = @"228d2a4a6c4a8572a2c1618b4466178b246ebab1";
    timestamp = @1459216383;
    [self loadDataForType:2 url:url sig:sig timestamp:timestamp];

//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

-(NSString *)getLoadActionName:(int)actionIndex {
    if (actionIndex == 0) {
        return @"shares";
    } else if (actionIndex == 1) {
        return @"subscribed_subjects";
    }
    return @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SXSCREEN_W, 20)];
    
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
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerLabelClick:)]];
        
        if (i == _labelIndex) {
            label.textColor = [UIColor blueColor];
        }
        [_headerLabelView addSubview:label];
    }
    
    [_headerLabelView setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return _headerLabelView;
}

//section header label 点击
-(void)headerLabelClick:(UITapGestureRecognizer *)recognizer {
    UILabel *label = (UILabel *)recognizer.view;
    [_headerLabelView.subviews enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *stop) {
        if (idx != label.tag) {
            obj.textColor = [UIColor blackColor];
        }
    }];
    label.textColor = [UIColor blueColor];
    _labelIndex = label.tag;
    _currentPage = @1;
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sharesList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_labelIndex == 0) {
        AuthorShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"share" forIndexPath:indexPath];
        cell.model = _sharesList[indexPath.row];
        return cell;
    } else if (_labelIndex == 1) {
        AuthorSubscribedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subject" forIndexPath:indexPath];
        cell.model = _sharesList[indexPath.row];
        return cell;
    }
    
//    AuthorSharesModel *model = _sharesList[indexPath.row];
    return [UITableViewCell new];
}

-(NSString *)getCellIdentifier
{
    if (_labelIndex == 0) {
        return @"share";
    } else if (_labelIndex == 1) {
        return @"subject";
    }
    return @"";
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
