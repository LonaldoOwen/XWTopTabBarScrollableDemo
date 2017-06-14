//
//  XWBarLabel.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/1.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "XWBarLabel.h"

@implementation XWBarLabel


- (void)setUp{
    
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:18.0];
    self.scale = 0.0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //
        [self setUp];
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    // 修改字体颜色为红色
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    // 根据scale创建transform
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1 - minScale) * scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}



@end
