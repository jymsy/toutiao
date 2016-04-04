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
#import "DetailTabBarController.h"
#import "AuthorPopupController.h"
#import "AuthorPresentationController.h"
#import "PictureScrollCell.h"
#import "AuthorViewController.h"

@interface LatestArticlesViewController () <AvatarTappedDelegate, BannerTappedDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, AuthorNameTappedDelegate>

@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, strong) UIPopoverPresentationController *popoverPtc;
@property (nonatomic, strong) AuthorPopupController *authPopVC;
//* 用来记录当前的modal状态 */
@property (nonatomic, assign) BOOL presenting;

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
    self.presenting = YES;
    
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
    return self.articleList.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PictureScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    ArticleModel *articleModel = self.articleList[indexPath.row -1];
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
    cell.article = articleModel;
    cell.delegate = self;
    return cell;
}

#pragma mark - /************************* tbv代理方法 ***************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    return 97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中图片banner
    if (indexPath.row == 0) {
        return ;
    }
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ArticleDetailViewController *advc = [[UIStoryboard storyboardWithName:@"ArticleDetail" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//    DetailTabBarController *advc = [[UIStoryboard storyboardWithName:@"ArticleDetail" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    DetailTabBarController *advc = [[DetailTabBarController alloc]init];
    
    ArticleModel *model = self.articleList[indexPath.row - 1];
    //    advc.articleID = model.id;
    advc.navigationItem.title = model.title;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [advc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:advc animated:YES];
    
}

-(void)avatarTapped:(ArticleModel *)article avatar:(UIImageView *)avatar{
    NSLog(@"tapped %@", article.title);
    AuthorPopupController *authPopVC = [[AuthorPopupController alloc] init];
    authPopVC.modalPresentationStyle = UIModalPresentationCustom;
    authPopVC.transitioningDelegate = self;
    authPopVC.avatarUrl = article.user[@"avatar"];
    authPopVC.name = article.user[@"name"];
    authPopVC.userID = article.user[@"id"];
    authPopVC.delegate = self;
    [self presentViewController:authPopVC animated:YES completion:nil];
}

-(void)bannerTapped:(NSInteger)articleId title:(NSString *)title {
    DetailTabBarController *advc = [[DetailTabBarController alloc]init];
    advc.navigationItem.title = title;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [advc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:advc animated:YES];
}

-(void)authorNameTapped:(NSString *)userID avatarUrl:(NSString *)avatarUrl name:(NSString *)name{
//    AuthorViewController *authorVC = [[AuthorViewController alloc] init];
    /* 加载名为AuthorView的Storyboard */
    AuthorViewController *authorVC = [[UIStoryboard storyboardWithName:@"AuthorView" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    authorVC.userID = userID;
    authorVC.avatarUrl = avatarUrl;
    authorVC.navigationItem.title = name;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [authorVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:authorVC animated:YES];

}

#pragma mark - popup delegate

//* 为控制器返回一个UIPresentationController */
//* 每当一个在一个控制器（ViewController）中新创建的一个新控制器（sVC）并试图modal后，都会为他创建一个UIPresentationController，用来控制这个控制器（sVC）的显示和移除 */
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    //* presented:要被modal出来的控制器（sVC） */
    //* presenting:被modal出来控制器的父控制器（ViewController） */
    //* 返回自定义的显示控制器 */
    //* 要自定义显示状态和modal动画，必须自定义显示控制器 */
    return [[AuthorPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

//* 返回控制器modal弹出（present）时候的显示动画的代理 */
//* 这里返回的仅仅是一个实现了UIViewControllerAnimatedTransitioning协议的代理，具体的动画效果，要在这个对象实现的代理方法里面去实现 */
//-(nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    return self;
//}
//
////* 返回控制器modal消失（dismiss）时候的显示动画的代理 */
////* 这里返回的仅仅是一个实现了UIViewControllerAnimatedTransitioning协议的代理，具体的动画效果，要在这个对象实现的代理方法里面去实现 */
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    //* 设置代理为父控制器（ViewController） */
//    return self;
//}

//* 设置动画持续时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;
}

//* 设置动画 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //* 无论是控制器的present还是dismiss，走的代理方法都是这个，所以需要自行判断当前的modal状态 */
    if (self.presenting) { //判断modal状态
        //* 设置present动画 */
        //* present的时候，toView是presentedView（要弹出的view，sVC的view） */
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//        toView.x = toView.width;
        [UIView animateWithDuration:0.2 animations:^{ //这里的动画持续时间要和上面的代理方法持续时间一致
//            toView.x = 0;
        } completion:^(BOOL finished) {
            //* 必须在动画结束后，设置过渡状态为完成过渡，否则控制器是不可交互状态 */
            [transitionContext completeTransition:YES];
            self.presenting = NO; //动画完成修改modal状态
        }];
    }else{
        //* 设置dismiss动画 */
        //* dismiss的时候，fromView是presentedView（要消失的view，sVC的view） */
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:0.2 animations:^{ //这里的动画持续时间要和上面的代理方法持续时间一致
//            fromView.x = -fromView.width;
        } completion:^(BOOL finished) {
            //* 必须在动画结束后，设置过渡状态为完成过渡，否则控制器是不可交互状态 */
            [transitionContext completeTransition:YES];
            self.presenting = YES; //动画完成修改modal状态
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.destinationViewController isKindOfClass:[ArticleDetailViewController class]]) {
//        ArticleDetailViewController *advc = segue.destinationViewController;
//        NSInteger row = self.tableView.indexPathForSelectedRow.row;
//        ArticleModel *model = self.articleList[row];
//        advc.articleID = model.id;
//        advc.navigationItem.title = model.title;
//        
//        
//    }
//}


@end
