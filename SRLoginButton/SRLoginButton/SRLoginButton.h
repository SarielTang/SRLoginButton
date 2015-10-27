//
//  SRLoginButton.h
//  SRLoginButton
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for SRLoginButton.
FOUNDATION_EXPORT double SRLoginButtonVersionNumber;

//! Project version string for SRLoginButton.
FOUNDATION_EXPORT const unsigned char SRLoginButtonVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SRLoginButton/PublicHeader.h>

#import "UIView+Extension.h"
#import "SRLoginButtonConfig.h"

@interface SRLoginButton : UIButton

@property (nonatomic,weak) id delegate;

///加载完成，执行之后的动画（在登录成功后调用）
- (void)loadingFinished;

@end