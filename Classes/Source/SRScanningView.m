//
//  SRScanningView.m
//  SRLoginViewController
//
//  Created by SarielTang on 15/10/26.
//  Copyright © 2015年 Sariel. All rights reserved.
//

#import "SRScanningView.h"

@implementation SRScanningView

+ (instancetype)sharedView {
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //        if (self.isClick == 2)
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /// 重新设置填充颜色
    //        CGContextSetRGBFillColor (context,  231/255.0, 231/255.0 , 231/255.0 , 1.0);//设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddArc(context, self.frame.size.width/2,self.frame.size.height/2,self.Radius, 0, 2*M_PI, 0);
    
    CGContextDrawPath(context, kCGPathFill);//填充
    
}


@end
