//
//  SRTileAnimator.m
//  SRLoginButtonDemo
//
//  Created by SarielTang on 15/10/29.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRTileAnimator.h"

@implementation SRTileAnimator

- (instancetype)initWithDuration:(NSTimeInterval)transitionDuration andStartAlpha:(CGFloat)startAlpha {
    if (self = [super init]) {
        self.transitionDuration = transitionDuration;
        self.startAlpha = startAlpha;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    __unused UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGFloat animateDuration = [self transitionDuration:transitionContext];
    UIView *loadingView = [[UIView alloc]initWithFrame:toView.bounds];
    loadingView.backgroundColor = [UIColor orangeColor];
    for (UIView *view in fromView.subviews) {
        NSLog(@"viewClass:%@",NSStringFromClass([view class]));
        if ([view isKindOfClass:[UIImageView class]]) {
            fromView = view;
        }
    }
    toView.alpha = self.startAlpha;
    
    [toView addSubview:loadingView];
    [containerView addSubview:toView];

    [UIView animateWithDuration:0.2 animations:^{
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animateDuration animations:^{
            toView.alpha = 1.0;
            loadingView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
