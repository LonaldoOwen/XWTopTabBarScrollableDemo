//
//  THSMainViewController2.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/4.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "THSMainViewController2.h"
#import "FirstViewController.h"

@interface THSMainViewController2 ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation THSMainViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // addControllers
    //[self addControllers];
    [self addControllersWithAutoLayout];
    
    
    //
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    /**
     * 说明：注释掉也没报错？？(很可能是因为在storyboard中用了auto layout）
     */
    //self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;//注释掉也没报错？？
    
    //
    //self.contentView.translatesAutoresizingMaskIntoConstraints = NO;//注释掉也没报错？？
    
    
    
    
}

//#MARK:helper method

- (void)addControllers{
    
    for (int i = 0; i < 5; i++) {
        
        CGFloat frameW = self.scrollView.frame.size.width;
        CGFloat frameH = self.scrollView.frame.size.height;
        CGFloat frameX = i * frameW;
        CGFloat frameY = 0;
        
        FirstViewController *firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        
        CGRect frame = CGRectMake(frameX, frameY, frameW, frameH);
        firstVC.view.frame = frame;
        firstVC.indexValue = [NSString stringWithFormat:@"%d", i];
        [self addChildViewController:firstVC];
        [self.contentView addSubview:firstVC.view];
        //[firstVC didMoveToParentViewController:self];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(5*self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

- (void)addControllersWithAutoLayout{

    FirstViewController *firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    FirstViewController *secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    
    UIView *view1 = firstVC.view;
    UIView *view2 = secondVC.view;
    
    
    firstVC.indexValue = @"1";
    secondVC.indexValue = @"2";
    view2.backgroundColor = [UIColor orangeColor];// 此处设置不起作用
    
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    [self.contentView addSubview:view1];
    [self.contentView addSubview:view2];
    
    //
    /**
     * 说明：未添加此处语句导致布局问题
       问题：页面无法正常显示，布局混乱
     */
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    // add constraints
//    [view1.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0.0].active = YES;
//    [view2.leadingAnchor constraintEqualToAnchor:view1.trailingAnchor constant:0.0].active = YES;
//    [self.contentView.trailingAnchor constraintEqualToAnchor:view2.trailingAnchor constant:0.0].active = YES;
//    [view1.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor constant:0.0].active = YES;//view1宽度与scrollView相同
//    [view2.widthAnchor constraintEqualToAnchor:view1.widthAnchor constant:0.0].active = YES;//view2宽度和view1相同
//    
//    [view1.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
//    [self.contentView.bottomAnchor constraintEqualToAnchor:view1.bottomAnchor constant:0.0].active = YES;
//    [view2.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
//    [self.contentView.bottomAnchor constraintEqualToAnchor:view2.bottomAnchor constant:0.0].active = YES;
//    [view1.heightAnchor constraintEqualToAnchor:self.scrollView.heightAnchor constant:0.0].active = YES;//view1高度和scrollView相同
//    [view2.heightAnchor constraintEqualToAnchor:view1.heightAnchor constant:0.0].active = YES;//view2高度和view1相同
    
    
    
    
    
    
    // add constraints with VFL
    // 方法一：
    //
    /**
     * 说明：metrics通常配置一些常量，为具体的数值，如：margins等；所以要使用metrics来设置view的width和height值，就要精确计算，不适合Equal Widths、Equal Heights等Anchor
       存在问题：viewWidth＝CGRectGetWidth(self.scrollView.frame)，显示时就是该方法获取的值，效果和scrollViw.widthAnchor不一样
     */
//    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:@(CGRectGetWidth(self.scrollView.frame)), @"viewWidth", @(CGRectGetHeight(self.scrollView.frame)), @"viewHeight", nil];
//    NSLog(@"metrics:%@", metrics);
//    
//    NSDictionary *views = [NSDictionary dictionaryWithObjectsAndKeys:view1, @"view1", view2, @"view2", nil];
//    NSLog(@"views:%@", views);
//    
//    NSLayoutFormatOptions options = NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom;
//    
//    NSString *horizontalConstraintsVFL = @"H:|[view1(viewWidth)]-0-[view2(viewWidth)]|";
//    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintsVFL options:options metrics:metrics views:views];//options设置0:不使用任何options
//    [self.contentView addConstraints:horizontalConstraints];
//    
//    NSString *verticalConstraintsVFL = @"V:|[view1(viewHeight)]-|";
//    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsVFL options:0 metrics:metrics views:views];
//    [self.contentView addConstraints:verticalConstraints];
    
    // 方法二：(和使用Anchor效果一致)
    //NSDictionary *metrics =
    NSDictionary *views = [NSDictionary dictionaryWithObjectsAndKeys:self.view, @"rootView", self.scrollView, @"scrollView", view1, @"view1", view2, @"view2", nil];
    
    NSLayoutFormatOptions options = NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom;
    
    /**
     * 注意：‘-0-’表示间距为0(也可以为空)；‘-’表示使用系统默认间距
     */
    NSString *horizontalConstraintsVFL = @"H:|[view1(==scrollView)]-[view2(==scrollView)]-0-|";
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintsVFL options:options metrics:nil views:views];
    [self.scrollView addConstraints:horizontalConstraints];
    
    NSString *verticalConstraintsVFL = @"V:|[view1(scrollView)]|";
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsVFL options:options metrics:nil views:views];
    [self.scrollView addConstraints:verticalConstraints];
    
    
    
    //
    NSLog(@"view1.constraints:%@", view1.constraints);
    NSLog(@"view2.constraints:%@", view2.constraints);
    NSLog(@"contentView.constraints:%@", self.contentView.constraints);
    NSLog(@"scrollView.constraints:%@", self.scrollView.constraints);
    
}



@end
