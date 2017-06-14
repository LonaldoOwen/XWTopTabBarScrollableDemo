//
//  THSMainViewController.m
//  XWTopTabBarScrollableDemo
//
//  Created by owen on 16/7/3.
//  Copyright © 2016年 owen. All rights reserved.
//
/**
 * 功能：实现同花顺资讯页面top tap bar（固定数量、可循环滚动）
   1、item字体有变化
   2、item下显示指示条
   3、5个页面可循环滚动
   4、contentScrollView未添加contentView，直接在其上面添加subviews
 */

#import "THSMainViewController.h"
#import "THSLabel.h"
#import "FirstViewController.h"

@interface THSMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) UIView *customTitleView;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *pageIndicatorView;




@end

@implementation THSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    
    // 修改导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width -2*8;
    
    
    
    /**  创建top tap bar  */
    // 创建customTitleView用于显示整个top tap bar
    self.customTitleView = [[UIView alloc] init];
    self.customTitleView.bounds = CGRectMake(0, 0, screenW, 44);
    self.customTitleView.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = self.customTitleView;
    //self.navigationItem.titleView.clipsToBounds = YES;
    
    // 创建topView用于显示item title
    self.topView = [[UIView alloc] init];
    self.topView.frame = CGRectMake(0, 0, screenW, 36.0);
    self.topView.backgroundColor = [UIColor redColor];
    [self.customTitleView addSubview:self.topView];
    
    // 创建pageIndicatorView用于显示提示条
    self.pageIndicatorView = [[UIView alloc] init];
    self.pageIndicatorView.frame = CGRectMake(0, 36.0, screenW, 4.0);
    self.pageIndicatorView.backgroundColor = [UIColor redColor];
    [self.customTitleView addSubview:self.pageIndicatorView];
    
    // add labels
    [self addLabels];
    
    
    
    /** 创建、配置contentScrollView */
    // add contrllers
    [self addControllers];
    
    // 设置代理到当前VC
    self.contentScrollView.delegate = self;
    
    // 配置contentScrollView（可以放到addController里面）
    /**
     * 说明：使用屏幕宽度和contentScrollView的宽度（600）是不一样的???
       问题：如果使用self.contentScrollView.frame.size.width，启动后启动页offset为｛600，0｝；滚动后就变为｛375，0｝？？？
     */
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    //CGFloat contentX  = self.childViewControllers.count * self.contentScrollView.frame.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentX, 0);// content尺寸
    self.contentScrollView.pagingEnabled = YES;// 开启分页
    //self.contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
     NSLog(@"contentSize:%@", NSStringFromCGSize(self.contentScrollView.contentSize));
    
    
    
    /** 添加默认显示页 */
    // 调整默认显示VC的offset
    /**
     * 说明：此处加载，使用self.contentScrollView.frame.size.width，默认页的offset为{600, 0}
       妥协：暂时使用[UIScreen mainScreen].bounds.size.width替换
     */
    //CGFloat offsetX = self.contentScrollView.frame.size.width;
    CGFloat offsetX = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetY = self.contentScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    //[self.contentScrollView setContentOffset:offset animated:YES];
    [self.contentScrollView setContentOffset:offset animated:NO];
    
    // 默认加载第二页
    /**
     * 说明：先调整offset再添加subview和反过来结果不一样
       存在问题：如果先添加默认subview再设置offset，启动时默认页view不显示（调整顺序后正常）
     */
    FirstViewController *secondVC = [self.childViewControllers objectAtIndex:1];
    secondVC.view.frame = self.contentScrollView.bounds;// 设置view的尺寸于scrollView相同
    [self.contentScrollView addSubview:secondVC.view];
    
    // top bar item 默认显示第一个
    THSLabel *label = [self.topView.subviews firstObject];
    label.scale = 1.0;
    UIView *indicatior = [self.pageIndicatorView.subviews firstObject];
    indicatior.hidden = NO;



    // 验证加载时各view的尺寸
    NSLog(@"self.view:%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"self.contentScrollView:%@", NSStringFromCGRect(self.contentScrollView.frame));
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear:");
    
    // 调整默认显示VC的offset
    /**
     * 说明：此处加载，self.contentScrollView.frame.size.width，默认页的offset为{600, 0}
     */
//    CGFloat offsetX = self.contentScrollView.frame.size.width;
//    //CGFloat offsetX = [UIScreen mainScreen].bounds.size.width;
//    CGFloat offsetY = self.contentScrollView.contentOffset.y;
//    CGPoint offset = CGPointMake(offsetX, offsetY);
//    
//    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear:");
    
    //
    /**
     * 说明：在此处设置offset，self.contentScrollView.frame.size.width，默认页的offset为{375, 0}
       如果显示动画，显示时会有动画过程；如果不显示动画，载入后不显示view的index
     */
//    CGFloat offsetX = self.contentScrollView.frame.size.width;
//    //CGFloat offsetX = [UIScreen mainScreen].bounds.size.width;
//    CGFloat offsetY = self.contentScrollView.contentOffset.y;
//    CGPoint offset = CGPointMake(offsetX, offsetY);
//    
//    [self.contentScrollView setContentOffset:offset animated:NO];
    
    
   
    

}


- (void)viewWillLayoutSubviews{
    //
    NSLog(@"viewWillLayoutSubviews");
    
    /**
     * 说明：不在此处设置起始offset，因为top tap bar对应VC的root view不是一次添加上的，是动态添加的，所以每添加一个都会调用一次此方法，这样就会重复设置起始offset
       如果是使用auto layout 或一次直接添加完毕，可以使用此方法
     */
    // 调整默认显示VC的offset
//    CGFloat offsetX = self.contentScrollView.frame.size.width;
//    CGFloat offsetY = self.contentScrollView.contentOffset.y;
//    CGPoint offset = CGPointMake(offsetX, offsetY);
//    
//    [self.contentScrollView setContentOffset:offset animated:NO];
    
}



//MARK:helper method
/**
  add controllers
 */
- (void)addControllers{
    
    NSArray *titleArray = @[@"要闻", @"滚动", @"机会", @"公司", @"更多"];
    NSMutableArray *newTitleArray = [NSMutableArray arrayWithArray:titleArray];
    [newTitleArray insertObject:@"更多" atIndex:0];
    [newTitleArray addObject:@"要闻"];
    
    for (int i = 0; i < newTitleArray.count; i ++) {
        
        FirstViewController *firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        
        firstVC.indexValue = [NSString stringWithFormat:@"%d", i];
        firstVC.title = [newTitleArray objectAtIndex:i];
        [self addChildViewController:firstVC];
        
    }
    
}

/**
  add labels
 */
- (void)addLabels{
    
    NSArray *titleArray = @[@"要闻", @"滚动", @"机会", @"公司", @"更多"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        CGFloat labelW = ([UIScreen mainScreen].bounds.size.width -2*8) / 5 ;
        CGFloat labelH = 36.0;
        CGFloat labelX = i*labelW;
        CGFloat labelY = 0.0;
        
        // 添加label
        THSLabel *label = [[THSLabel alloc] init];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.text = [NSString stringWithFormat:@"%@", titleArray[i]];
        label.tag = i;
        [self.topView addSubview:label];
        
        // 添加indicator
        UIView *indicatorView = [[UIView alloc] init];
        //indicatorView.frame = CGRectMake(labelX + 10, 0, labelW - 10.0, 4.0);
        indicatorView.bounds = CGRectMake(0, 0, labelW - 3*10.0, 4.0);
        indicatorView.center = CGPointMake(labelX + labelW/2, 2.0);
        indicatorView.backgroundColor = [UIColor whiteColor];
        indicatorView.tag = i;
        indicatorView.hidden = YES;
        [self.pageIndicatorView addSubview:indicatorView];
        
        // label添加手势识别：点击事件
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizier = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizier:)];
        [label addGestureRecognizer:tapGestureRecognizier];
    }
    
    
    
}

/**
  Tap手势：点击事件
 */
- (void)handleTapGestureRecognizier:(UIGestureRecognizer *)recognizier{
    //
    NSLog(@"tapGestureRecognizier:");
    
    // 点击top tab bar item 滚动对应VC
    UILabel *selectedLabel = (UILabel *)recognizier.view;
    NSLog(@"selected label tag:%ld", (long)selectedLabel.tag);
    
    CGFloat offsetX = (selectedLabel.tag + 1) * self.contentScrollView.frame.size.width;
    CGFloat offsetY = self.contentScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    //
    /**
     * 说明:当点击title需要conent由滚动动画效果时，设置animated为YES；不需要滚动动画效果时设置为NO，同时主动调用addContentAndMoveTopTapBarItemWithScroll方法完成content更新即title移动
     */
    //[self.contentScrollView setContentOffset:offset animated:YES];
    [self.contentScrollView setContentOffset:offset animated:NO];
    [self addContentAndMoveTopTapBarItemWithScroll:self.contentScrollView];
}

/**
 添加content，移动tab bar item
 */
- (void)addContentAndMoveTopTapBarItemWithScroll:(UIScrollView *)scrollView{
    NSLog(@"addContentAndMoveTopTapBarItemWithScroll");
    
    //
    // 计算索引值
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat pageWidth = self.contentScrollView.frame.size.width;
    NSInteger index = offsetX / [UIScreen mainScreen].bounds.size.width;
    
    NSLog(@":contentScrollView.width:%f", self.contentScrollView.frame.size.width);
    NSLog(@": index:%ld", index);
    
    
    // 添加content VC的root view
    [self addRootViewToContentViewWithIndex:index];
    /**
     * 说明：在此处实现跳转，（当index＝0先添加view0，再跳转到view5）
       解决问题：向右滚动从页面1跳到页面5时，预览不显示页面0（可解决该问题）
     */
    
    if (index == 0) {
        NSLog(@"jump to index 5");
        CGPoint offset = CGPointMake(5 * pageWidth, self.contentScrollView.contentOffset.y);
        //[self.contentScrollView setContentOffset:offset animated:NO];
        self.contentScrollView.contentOffset = offset;
        index = 5;
        // 添加content VC的root view
        [self addRootViewToContentViewWithIndex:index];
    }
    
    if (index == 6) {
        NSLog(@"jump to index 1");
        CGPoint offset = CGPointMake(1 * pageWidth, self.contentScrollView.contentOffset.y);
        //[self.contentScrollView setContentOffset:offset animated:NO];
        self.contentScrollView.contentOffset = offset;
        index = 1;
        // 添加content VC的root view
        [self addRootViewToContentViewWithIndex:index];
    }
    
    
    // 滚动标题（不是scrollView，只是view的隐式动画，看起来像滚动）
    // 设置top tap bar item状态
    for (int i = 0; i < self.topView.subviews.count; i ++) {
        
        THSLabel *label = self.topView.subviews[i];
        UIView *indicatior = self.pageIndicatorView.subviews[i];
        
        if (i == index - 1) {
            label.scale = 1.0;
            indicatior.hidden = NO;
        } else {
            label.scale = 0.0;
            indicatior.hidden = YES;
        }
    }

}


//#MARK:UIScrollViewDelegate
// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //
    NSLog(@"scrollViewDidScroll: offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    //
//    CGFloat pageVidth = self.contentScrollView.frame.size.width;
//    CGFloat offsetX = scrollView.contentOffset.x;
//    
//    //NSInteger index = scrollView.contentOffset.x / pageVidth;
//    NSInteger index = (offsetX - pageVidth/2) / pageVidth + 1;
//    NSLog(@"scrollViewDidScroll: index:%ld", index);
    
    
    //
    /**
     * 说明：在此处实现跳转，
       存在问题：向右滚动从页面1跳到页面5时，预览不显示页面0；原因：页面0尚未添加为subview就直接跳到页面5了
       解决：在此处跳转到页面5时，先将页面0添加到contentScrollView的subviews
     */
//    if (offsetX == 0) {
//        NSLog(@"jump to index 5");
//        //
//        [self addRootViewToContentViewWithIndex:0];
//        
//        CGPoint offset = CGPointMake(5 * pageVidth, self.contentScrollView.contentOffset.y);
//        /**
//         * 说明：使用.contentOffset替换setContentOffset解决不显示view的问题
//           问题：使用setContentOffset设置offset，1-->5,5-->1时，对应view上的数字不显示？？？
//         */
//        //[self.contentScrollView setContentOffset:offset animated:NO];
//        self.contentScrollView.contentOffset = offset;
//    }
//    
//    if (offsetX == 6 * pageVidth) {
//        NSLog(@"jump to index 1");
//        //
//        [self addRootViewToContentViewWithIndex:6];
//        CGPoint offset = CGPointMake(1 * pageVidth, self.contentScrollView.contentOffset.y);
//        //[self.contentScrollView setContentOffset:offset animated:NO];
//        self.contentScrollView.contentOffset = offset;
//    }
    
    
    // 添加content 移动tab bar item
    /**
     * 说明：不要在此处添加此方法
       问题：一滚动就添加了content，移动了title（没有了动画效果，在手动滚动时不使用，只适用点击title）
     */
    //[self addContentAndMoveTopTapBarItemWithScroll:scrollView];
    
    
}

// 滚动减速停止代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //
    NSLog(@"scrollViewDidEndDecelerating:");
    
    // 当手动滑动页面时，手动调用代理方法- scrollViewDidEndScrollingAnimation:
    //[self scrollViewDidEndScrollingAnimation:scrollView];
    
    [self addContentAndMoveTopTapBarItemWithScroll:scrollView];
    
}

// 滚动动画结束
/**
 * 如果点击top tap bar item， scroll view未设置动画，此方法不调用
   手动滑动屏幕滚动，也不会调用此代理方法
 */
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    //
//    NSLog(@"scrollViewDidEndScrollingAnimation:offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
//    
//    
//    // 添加content 移动tab bar item
//    [self addContentAndMoveTopTapBarItemWithScroll:scrollView];
//
//    
//}

// 添加content VC的root view
- (void)addRootViewToContentViewWithIndex:(NSInteger)index{
    
    FirstViewController *firstVC = [self.childViewControllers objectAtIndex:index];
    firstVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:firstVC.view];
    
    NSLog(@"contentScrollView.bounds:%@", NSStringFromCGRect(self.contentScrollView.bounds));
    //NSLog(@"subviews:count:%lu, %@",(unsigned long)self.contentScrollView.subviews.count , self.contentScrollView.subviews);
    NSLog(@"subviews:count:%lu",(unsigned long)self.contentScrollView.subviews.count);
}





@end
