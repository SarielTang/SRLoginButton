//
//  SRLoginButtonConfig.h
//  SRLoginButton
//
//  Created by SarielTang on 15/10/27.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#ifndef SRLoginButtonConfig_h
#define SRLoginButtonConfig_h

#import "SRScanningView.h"
#import "SRTransitionLoadingView.h"

@class SRLoginButton;
@protocol SRLoginButtonDelegate <NSObject>

//@required
///登录按钮被点击
- (void)SRLoginButtonDidClicked:(SRLoginButton *)btn;

///登录成功，开始加载下一个页面
- (void)SRLoginButtonShowNextPage:(SRLoginButton *)btn;

@end

#endif /* SRLoginButtonConfig_h */
