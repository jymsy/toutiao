//
//  AuthorPresentationController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/21.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorPresentationController.h"

@implementation AuthorPresentationController

-(CGRect)frameOfPresentedViewInContainerView {
//    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    
    CGFloat popW = containerBounds.size.width - 50;
    CGFloat popH = popW;
    CGFloat popX = (containerBounds.size.width - popW) / 2;
    CGFloat popY = (containerBounds.size.height - popH) / 2;
//    presentedViewFrame.size = CGSizeMake(floorf(containerBounds.size.width / 2.0), floorf(containerBounds.size.height / 3.0));
//    presentedViewFrame.origin.x = (containerBounds.size.width - presentedViewFrame.size.width) / 2;
    return CGRectMake(popX, popY, popW, popH);
    
}

@end
