//
//  DetaiTabBar.h
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/20.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailTabBarDelegate <NSObject>

@optional
-(void)detailTabClicked:(NSInteger)tag;
@end

@interface DetaiTabBar : UIView

@property (nonatomic, weak) id<DetailTabBarDelegate> delegate;
-(void)addBarButton:(NSString *)title;

@end
