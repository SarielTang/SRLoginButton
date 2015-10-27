//
//  SRLoginViewController.m
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRLoginViewController.h"
#import <SRLoginButton/SRLoginButton.h>

@interface SRLoginViewController ()<SRLoginButtonDelegate>

@property (nonatomic,strong)SRLoginButton * btn;

@end

@implementation SRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showMainInterface];
}

//页面布局
- (void)showMainInterface {
    self.btn = [[SRLoginButton alloc]initWithFrame:CGRectMake(self.view.width * 0.5, self.view.height * 0.5 + 250, 150, 40)];
    [self.btn setTitle:@"Sign In" forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    self.btn.backgroundColor = [UIColor orangeColor];
    self.btn.delegate = self;
}

- (void)SRLoginButtonDidClicked:(SRLoginButton *)btn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"登录完成");
        ///加载完成，执行跳转
        [self.btn loadingFinished];
    });
}

- (void)SRLoginButtonShowNextPage:(SRLoginButton *)btn {
    //执行相关动画
    NSLog(@"执行转场动画");
    [UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor blueColor];
    }];
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
