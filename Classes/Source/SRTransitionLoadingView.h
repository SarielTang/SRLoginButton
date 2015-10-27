//
//  SRTransitionLoadingView.h
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

///加载过渡页
@interface SRTransitionLoadingView : UIView

+ (instancetype)sharedView;

/// 判断是否登录
@property (nonatomic, assign,getter=isLoading) BOOL loading;

@end
