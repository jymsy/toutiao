//
//  AuthorPresentationController.m
//  Toutiao
//
//  Created by 蒋羽萌 on 16/3/21.
//  Copyright © 2016年 蒋羽萌. All rights reserved.
//

#import "AuthorPresentationController.h"

@interface AuthorPresentationController()

@property (nonatomic, strong) UIView *dimmingView;

@end

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

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if(self) {
        // Create the dimming view and set its initial appearance.
        self.dimmingView = [[UIView alloc] init];
        [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
//        [self.dimmingView setAlpha:0.0];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    // Get critical information about the presentation.
    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];
    
    // Set the dimming view to the size of the container's
    // bounds, and make it transparent initially.
    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];
    
    // Insert the dimming view below everything else.
    [containerView insertSubview:[self dimmingView] atIndex:0];
    
    // Set up the animations for fading in the dimming view.
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator]
         animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                      context) {
             // Fade in the dimming view.
             [[self dimmingView] setAlpha:1.0];
         } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:1.0];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    // If the presentation was canceled, remove the dimming view.
    if (!completed)
        [self.dimmingView removeFromSuperview];
}

- (void)dismissalTransitionWillBegin {
    // Fade the dimming view back out.
    if([[self presentedViewController] transitionCoordinator]) {
        [[[self presentedViewController] transitionCoordinator]
         animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                      context) {
             [[self dimmingView] setAlpha:0.0];
         } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:0.0];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // If the dismissal was successful, remove the dimming view.
    if (completed)
        [self.dimmingView removeFromSuperview];
}


@end
