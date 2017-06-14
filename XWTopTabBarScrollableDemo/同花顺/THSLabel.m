//
//  THSLabel.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/3.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "THSLabel.h"

@implementation THSLabel

- (void)setUp{
    
    // 初始化设置
    self.font = [UIFont systemFontOfSize:18.0];
    self.textAlignment = NSTextAlignmentCenter;
    self.scale = 0.0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    //self.textColor = [UIColor colorWithRed:1/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    self.textColor = [UIColor whiteColor];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1 - minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
