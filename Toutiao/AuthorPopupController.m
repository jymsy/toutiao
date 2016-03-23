//
//  AuthorPopupController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorPopupController.h"

@interface AuthorPopupController ()

@end

@implementation AuthorPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:nil options:nil][0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 5.0;
    [self.view addSubview:view];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width - 80, 50, 20)];
//    btn.backgroundColor = [UIColor redColor];
//    btn.titleLabel.text = @"关注";
//    
//    [self.view addSubview:btn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"dismiss");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
