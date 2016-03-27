//
//  AuthorPopupController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorPopupController.h"
#import "UIImageView+WebCache.h"

@interface AuthorPopupController ()
@property (nonatomic, strong) IBOutlet UIView *popupView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *fath;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
//@property (nonatomic, strong) UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIButton *focus;

@end

@implementation AuthorPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.popupView = [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:nil options:nil][0];
    self.view = self.popupView;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 5.0;
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.width/2.0;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    self.focus.layer.cornerRadius = self.focus.bounds.size.height/2.0;
    self.authorName.text = self.name;
    self.closeBtn.layer.borderWidth = 0.5;
    self.closeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.closeBtn.layer.cornerRadius = 5;
}

-(UIView *)popupView {
    if (!_popupView) {
        [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:self options:nil];
    }
    return _popupView;
}

- (IBAction)closePopup:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}



//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"dismiss");
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
