//
//  SRTransitionLoadingView.m
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRTransitionLoadingView.h"

@implementation SRTransitionLoadingView

+ (instancetype)sharedView {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.isLoading) {
        ///开始loading
        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetRGBStrokeColor (context,  1, 1, 1, 1.0);//设置填充颜色
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 2);
        CGContextSetLineCap(context,kCGLineCapRound);
        
        CGContextAddArc(context, self.frame.size.width * 0.5,self.frame.size.height * 0.5,self.frame.size.height * 0.35, 0, 1.5*M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);// 空心
    }
    else
    {
        ///Loading结束
        CGContextRef context = UIGraphicsGetCurrentContext();
        /// 重新设置填充颜色
        CGContextSetRGBFillColor (context,  1, 107/255.0 , 0, 1.0);//设置填充颜色
        
        CGContextAddArc(context, self.frame.size.width * 0.5,self.frame.size.height * 0.5,([UIScreen mainScreen].bounds.size.height), 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathFill);//填充
    }
}


@end
