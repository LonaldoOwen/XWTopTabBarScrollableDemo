//
//  TestViewController.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/4.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *subView1;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    // 验证加载时各view的尺寸
    NSLog(@"screen width:%f", [UIScreen mainScreen].bounds.size.width);
    NSLog(@"self.view:%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"self.scrollView:%@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"self.scrollView.contentSize:%@", NSStringFromCGSize(self.scrollView.contentSize));
    NSLog(@"self.contentView:%@", NSStringFromCGRect(self.contentView.frame));
    NSLog(@"subView1:%@", NSStringFromCGRect(self.subView1.frame));
    //
    /**
     *
     2016-07-04 22:44:24.793 XWTopTabBarScrollableDemo[22330:2145532] screen width:375.000000
     2016-07-04 22:44:24.794 XWTopTabBarScrollableDemo[22330:2145532] self.view:{{0, 0}, {375, 667}}
     2016-07-04 22:44:24.794 XWTopTabBarScrollableDemo[22330:2145532] self.scrollView:{{0, 0}, {600, 600}}
     2016-07-04 22:44:24.794 XWTopTabBarScrollableDemo[22330:2145532] self.scrollView.contentSize:{0, 0}
     2016-07-04 22:44:24.794 XWTopTabBarScrollableDemo[22330:2145532] self.contentView:{{0, 0}, {600, 600}}
     2016-07-04 22:44:24.794 XWTopTabBarScrollableDemo[22330:2145532] subView1:{{20, 236}, {560, 128}}
     */

}



@end
