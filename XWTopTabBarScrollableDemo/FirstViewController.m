//
//  FirstViewController.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/2.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"firstVC viewWillAppear");
    
    if ([self.indexValue isEqualToString:@"0"]) {
        // 循环滚动时，item 0和item N内容相同
        self.indexLabel.text = @"5";
    } else {
        self.indexLabel.text = self.indexValue;
    }
    
    //
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}



@end
