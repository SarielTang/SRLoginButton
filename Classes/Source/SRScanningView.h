//
//  SRScanningView.h
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

///扫描效果页
@interface SRScanningView : UIView

+ (instancetype)sharedView;

/// 圆半径
@property (nonatomic, assign) CGFloat Radius;

@end
