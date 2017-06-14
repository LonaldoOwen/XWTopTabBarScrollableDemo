//
//  XWMainViewController.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/1.
//  Copyright © 2016年 owen. All rights reserved.
//

/**
  * 功能：实现类似网易新闻top tab bar 显示效果
   1、tab bar和content分别由一个scrolllView控制
   2、tab bar title显示使用label 添加gesture recognizier响应事件
   3、tab bar title使用的label是自定义的，可以处理文字的颜色和大小的渐变效果，滚动时，颜色和大小会有渐变效果
   4、content 的root view是动态添加上的，即：起初只默认显示一个，当滚动到当前页面时添加
   5、
  */

#import "XWMainViewController.h"
#import "XWBarLabel.h"
#import "FirstViewController.h"

@interface XWMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (assign, nonatomic) NSInteger selectedItem;
@property (strong, nonatomic) NSArray *arrayLists;

@end

@implementation XWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
     NSArray *titleArray = @[@"头条", @"足球", @"NBA", @"今日关注", @"美女", @"政治", @"财经", @"啪啪啪"];
    self.arrayLists = [NSArray arrayWithArray:titleArray];
    
    
    //
    //self.topScrollView.delegate = self;
    self.contentScrollView.delegate = self;
    
    //
    /**
     * 隐藏scroll view水平和垂直指示条
     * 问题：引起点击选择最后一个top tab bar时闪退
     */
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    
    
    // add controllers
    [self addControllers];
    // add labels
    [self addLabels];
    
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentX, 0);
    NSLog(@"contentScrollView contentSize:%@", NSStringFromCGSize(self.contentScrollView.contentSize));
    NSLog(@"didLoad:contentScrollView.width:%f", self.contentScrollView.frame.size.width);
    self.contentScrollView.pagingEnabled = YES;
    
    
    // 添加默认VC的root view
    UIViewController *initialVC = [self.childViewControllers objectAtIndex:0];
    initialVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:initialVC.view];
    XWBarLabel *initialLabel = [self.topScrollView.subviews firstObject];
    initialLabel.scale = 1.0;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"viewDidAppear:contentScrollView.width:%f", self.contentScrollView.frame.size.width);
}

- (void)addControllers{
    
    for (int i = 0; i < self.arrayLists.count; i++) {
        
        FirstViewController *firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        firstVC.indexValue = [NSString stringWithFormat:@"%d", i];
        firstVC.title = [self.arrayLists objectAtIndex:i];
        [self addChildViewController:firstVC];
    }
    
}


- (void)addLabels{
    
    //
    NSInteger tabListsCount = self.arrayLists.count;
    
    for (int i = 0; i < tabListsCount; i++) {
        
        CGFloat labelW = 70.0;
        CGFloat labelH = 40.0;
        CGFloat labelY = 0.0;
        CGFloat labelX = i * labelW;
        
        UIViewController *viewController = [self.childViewControllers objectAtIndex:i];
        
        XWBarLabel *label = [[XWBarLabel alloc] init];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        //label.font = [UIFont systemFontOfSize:16.0];
        //label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        label.text = viewController.title;
        [self.topScrollView addSubview:label];
        
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizier:)];
        [label addGestureRecognizer:tapRecognizer];
    }
    
    self.topScrollView.contentSize = CGSizeMake(tabListsCount*70.0, 40.0);
    
    NSLog(@"top subviews:%@", self.topScrollView.subviews);
    NSLog(@"top subviews count:%ld", self.topScrollView.subviews.count);
}

- (void)handleTapRecognizier:(UIGestureRecognizer *)recognizier{
    //
    NSLog(@"handleTapRecognizier:");
    
    //  点击top bar contentScrollView对应的VC翻页
    XWBarLabel *selectedLabel = (XWBarLabel *)recognizier.view;
    
    CGFloat offsetX = selectedLabel.tag * self.contentScrollView.frame.size.width;
    CGFloat offsetY = self.contentScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.contentScrollView setContentOffset:offset animated:YES];

}




//#MARK:UIScrollViewDelegate

// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //
    NSLog(@"scrollViewDidScroll:content offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    // 求结对值
    //ABS(<#A#>)
//    NSLog(@"abs:%d", abs(2));
//    //NSLog(@"fabsf:%f", fabsf(2.5));
//    NSLog(@"fabs:%g",fabs(-2.7));
//    NSLog(@"ABS:%d", ABS(-2));
    
    // 创建scale值，实现title文字渐变效果
    CGFloat value = scrollView.contentOffset.x / self.contentScrollView.frame.size.width;
    //NSLog(@"value:%f", value);
    value = ABS(value);
    NSInteger leftIndex = (int)value;
    NSInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    
    XWBarLabel *leftLabel = [self.topScrollView.subviews objectAtIndex:leftIndex];
    leftLabel.scale = scaleLeft;
    
    //NSLog(@"topScrollView subviews:%lu", (unsigned long)self.topScrollView.subviews.count);
    // 
    if (rightIndex < self.topScrollView.subviews.count) {
        XWBarLabel *rightLabel = [self.topScrollView.subviews objectAtIndex:rightIndex];
        rightLabel.scale = scaleRight;
        NSLog(@"");
    }
    
    //NSLog(@"ABS(value):%f, leftIndex:%ld, rightIndex:%ld, scaleLeft:%f, scaleRight:%f", value, leftIndex, rightIndex, scaleLeft, scaleRight);
}

// 滑动手势结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //
    NSLog(@"scrollViewDidEndDecelerating:");
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 滚动结束掉用（调用setContentOffset: animated:方法导致）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //
    NSLog(@"scrollViewDidEndScrollingAnimation:%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    // 获取当前VC索引
    NSLog(@"contentScrollView.width:%f", self.contentScrollView.frame.size.width);
    NSInteger index = scrollView.contentOffset.x / self.contentScrollView.frame.size.width;
    
    
    // 滚动标题栏
    XWBarLabel *selectedLabel = (XWBarLabel *)[self.topScrollView.subviews objectAtIndex:index];
    CGFloat offsetX = selectedLabel.center.x - self.topScrollView.frame.size.width/2;//
    CGFloat offsetXMax = self.topScrollView.contentSize.width - self.topScrollView.frame.size.width;
    
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > offsetXMax) {
        offsetX = offsetXMax;
    }
    
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.topScrollView setContentOffset:offset animated:YES];
    
    /**
     * 说明：如果不是当前tab bar item，scale均设置为0；
       解决top tab bar从第一个item直接跳到中间偏后的item时，之间的item会显示轻微的红色
     */
    [self.topScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != index) {
            XWBarLabel *label = [self.topScrollView.subviews objectAtIndex:idx];
            label.scale = 0.0;
        }
    }];
    
    
    // contentScrollView添加subview
    FirstViewController *firstVC = [self.childViewControllers objectAtIndex:index];
    firstVC.view.frame = scrollView.bounds;
    [self.contentScrollView addSubview:firstVC.view];
    
}



@end
