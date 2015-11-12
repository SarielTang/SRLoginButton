//
//  SRLoginViewController.m
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRLoginViewController.h"
#import <SRLoginButton/SRLoginButton.h>
#import "SRTileAnimator.h"
#import "ViewController.h"

@interface SRLoginViewController ()<SRLoginButtonDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)SRLoginButton * btn;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showLoginView];
}

//页面布局
- (void)showLoginView {
    self.btn = [[SRLoginButton alloc]initWithFrame:CGRectMake((self.view.width - 150) * 0.5, self.view.height * 0.5 + 250, 150, 40)];
    [self.btn setTitle:@"Sign In" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.btn];
    self.btn.delegate = self;
}

- (void)SRLoginButtonDidClicked:(SRLoginButton *)btn {
    //模拟网络加载，延迟3秒。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"登录完成");
        ///加载完成，执行跳转
        [self.btn loadingFinished];
    });
//    if ([self.delegate respondsToSelector:@selector(SRLoginButtonDidClicked:)]) {
//        [self.delegate SRLoginButtonDidClicked:self.btn];
//    }
}

- (void)SRLoginButtonShowNextPage:(SRLoginButton *)btn {
    //执行相关动画
    NSLog(@"执行转场动画");
    //另一个控制器
    _nextController = [[ViewController alloc]init];
    if (_nextController) {
        self.nextController.transitioningDelegate = self;
        [self presentViewController:self.nextController animated:YES completion:nil];
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[SRTileAnimator alloc]initWithDuration:1 andStartAlpha:0.3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
