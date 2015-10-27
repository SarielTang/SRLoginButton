//
//  SRLoginButton.m
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRLoginButton.h"
#import "SRScanningView.h"
#import "SRTransitionLoadingView.h"

#define  MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define  MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface SRLoginButton ()

/// 登录计时器
@property (nonatomic,strong) NSTimer* loadingTimer;

/// 计算扫描效果切图半径的计时器
@property (nonatomic,strong) NSTimer * scanningTimer;

/// 改变扫描效果的frame.width
@property (nonatomic,assign) CGFloat scanningWidth;

/// 旋转动画
@property (nonatomic,strong) CABasicAnimation* rotationAnimation;

/// 设置大圆layer渐变的定时器
@property (nonatomic,strong) NSTimer* stealthTimer;

/// 消除按钮定时器
@property (nonatomic,strong) NSTimer* timer;

///扫描视图
@property (nonatomic, strong)SRScanningView *scanningView;

///button中心
@property (nonatomic, assign)CGPoint btnCenter;

///加载视图
@property (nonatomic, strong)SRTransitionLoadingView *loadingView;

@end

@implementation SRLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.btnCenter = self.center;
        self.layer.cornerRadius = frame.size.height * 0.5;
        self.layer.masksToBounds = YES;
        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick {
    //防止被重复点击
    self.userInteractionEnabled = NO;
    if ([self.delegate respondsToSelector:@selector(SRLoginButtonDidClicked:)]) {
        [self.delegate SRLoginButtonDidClicked:self];
    }
    
    //先声明加载用的转场View
    [SRTransitionLoadingView sharedView].loading = YES;
    
    self.scanningWidth = self.width * 0.2;
    self.scanningView = [[SRScanningView alloc]init];
    self.scanningView.bounds = CGRectMake(0, 0, self.scanningWidth, self.height);
    self.scanningView.layer.masksToBounds = YES;
    self.scanningView.center = self.center;
    self.scanningView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0];
    [self.superview addSubview:self.scanningView];
    self.scanningView.Radius = self.height;
    [self.scanningView setNeedsDisplay];
    
    [UIView animateWithDuration:0.2 animations:^{
        //在动画播放过程中定时增加圆半径，模拟扫描效果
        self.scanningTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(selfAddition) userInfo:nil repeats:YES];
        self.scanningView.alpha = 0.2;
    } completion:^(BOOL finished) {
        /// 开始加载动画
        self.loadingTimer= [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(startLoadingAnimation) userInfo:nil repeats:NO];
    }];
}

//圆半径自增，模拟扫描
- (void) selfAddition {
    self.scanningView.Radius += self.width * 0.0125;
    self.scanningWidth += self.width * 0.025;
    self.titleLabel.alpha -= 0.045;
    self.scanningView.frame = CGRectMake(0, 0, self.scanningWidth, self.height);
    self.scanningView.center = self.center;
    [self.scanningView setNeedsDisplay];
    if (self.scanningWidth >= (self.width * 0.7)) {
        [self.scanningTimer invalidate];
        [self.scanningView removeFromSuperview];
    }
    
}

// 开始加载动画
- (void)startLoadingAnimation {
    self.loadingView = [SRTransitionLoadingView sharedView];
    [self.loadingView setNeedsDisplay];
    self.loadingView.bounds = CGRectMake(0, 0, self.height, self.height);
    self.loadingView.center = self.center;
    self.loadingView.layer.cornerRadius = self.height * 0.5;
    self.loadingView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0];
    
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    self.rotationAnimation.duration = 1;
    self.rotationAnimation.cumulative = YES;
    self.rotationAnimation.repeatCount = MAXFLOAT;
    
    [self.loadingView.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    
    [self.superview addSubview:self.loadingView];
    
    /// 按钮变化
    [UIView animateWithDuration:0.7 animations:^{
        self.frame = CGRectMake(0, 0, self.height, self.height);
        self.center = self.btnCenter;
        self.loadingView.center = self.center;
    }];
}

///登录成功
- (void)loadingFinished {
    self.stealthTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(transitionAnimation) userInfo:nil repeats:NO];
}

/// 转场动画
- (void) transitionAnimation {
    [UIView animateWithDuration:0.7 animations:^{
        self.loadingView.loading = NO;
        // 圆开始变大
        self.loadingView.frame= CGRectMake(0, 0, MAIN_SCREEN_HEIGHT*2,MAIN_SCREEN_HEIGHT*2);
        self.loadingView.center = self.center;
        [self.loadingView setNeedsDisplay];
        self.rotationAnimation.repeatCount = 0;
        self.rotationAnimation.cumulative = NO;
        
        self. timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showNextPage) userInfo:nil repeats:NO];
        
        [self.loadingView.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
        [self.superview addSubview:self.loadingView];
        
    }];
}

/// 页面跳转
- (void)showNextPage {
    [UIView animateWithDuration:0.5 animations:^{
        self.loadingView.alpha = 0;
        self.userInteractionEnabled = YES;
    }];
    
    ///显示跳转后的页面
    if ([self.delegate respondsToSelector:@selector(SRLoginButtonShowNextPage:)]) {
        [self.delegate SRLoginButtonShowNextPage:self];
    }
    
    self.alpha = 0;
    self.loadingView.alpha = 0;
    self.loadingView.loading = YES;
}

@end
