//
//  AuthorPopupController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorPopupController.h"

@interface AuthorPopupController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *fath;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UILabel *authorName;

@end

@implementation AuthorPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:nil options:nil][0];
    [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:self options:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 5.0;
    [self.view addSubview:self.popupView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"dismiss");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
