//
//  SRTileAnimator.h
//  SRLoginButtonDemo
//
//  Created by SarielTang on 15/10/29.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTileAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign)NSTimeInterval transitionDuration;
@property (nonatomic,assign)CGFloat startAlpha;

- (instancetype)initWithDuration:(NSTimeInterval)transitionDuration andStartAlpha:(CGFloat)startAlpha;

@end
