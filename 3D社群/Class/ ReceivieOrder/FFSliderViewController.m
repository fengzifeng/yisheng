//
//  FFSliderViewController.m
//  3D社群
//
//  Created by fengzifeng on 2017/11/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFSliderViewController.h"
#import "FFCarViewController.h"

@interface FFSliderViewController () <FFCarViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

@property (nonatomic, strong) UIViewController *leftVc;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRec;
@end

static NSTimeInterval animationTime = 0.2;

@implementation FFSliderViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController contentViewController:(UIViewController *)leftVc {
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
//        if ([_rootViewController isKindOfClass:[FFCarViewController class]]) ((FFCarViewController *)_rootViewController).delegate = self;
        
        _leftVc = leftVc;
    }
    return self;
}

// 控制状态栏
- (BOOL)prefersStatusBarHidden {
    return self.hideStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

//- (void)navigationBackButtonAction:(UIButton *)sender
//{
//    [self.panGestureRec removeTarget:self action:@selector(moveViewWithGesture:)];
//    [super navigationBackButtonAction:sender];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBackButtonDefault];

    // 半透明的view
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.alpha = 0;
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    // 添加两个手势
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    [bgView addGestureRecognizer:tapGestureRec];
    
    self.panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [self.view addGestureRecognizer:self.panGestureRec];
    
    self.leftVc.view.backgroundColor = [UIColor redColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if ([UIScreen mainScreen].bounds.size.width > 375) {
        width -= 100;
    } else if ([UIScreen mainScreen].bounds.size.width > 320) {
        width = width - 100;
    }
    self.rootViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height);
//    self.rootViewController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addChildViewController:self.rootViewController];
    [self.view insertSubview:self.rootViewController.view atIndex:0];
    
    self.leftVc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, width, [UIScreen mainScreen].bounds.size.height);
    self.leftVc.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.leftVc.view];
    [self addChildViewController:self.leftVc];
    
    if ([_rootViewController isKindOfClass:[FFCarViewController class]]) ((FFCarViewController *)_rootViewController).delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (!self.hasShow) {
//        self.hasShow = YES;
//        self.hideStatusBar = YES;
//        [UIView animateWithDuration:animationTime animations:^{
//            [self setNeedsStatusBarAppearanceUpdate];
//            self.rootViewController.navigationController.navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
//        }];
//    }
    //    self.hideStatusBar = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self showUpdateAnimation];
}


- (void)showUpdateAnimation
{


    [self showAnimation];

}

/**
 显示控制器
 */
- (void)showAnimation {
    self.bgView.hidden = NO;
    self.panGestureRec.enabled = YES;

//    self.view.userInteractionEnabled = NO;
    //根据当前x，计算显示时间
    //    CGFloat time = fabs(self.leftVc.view.frame.origin.x / self.leftVc.view.frame.size.width) * animationTime;
    [UIView animateWithDuration:.2 animations:^{
        self.leftVc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - self.leftVc.view.frame.size.width, 0, self.leftVc.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
        self.bgView.alpha = 0.5;
    } completion:^(BOOL finished) {
//        self.view.userInteractionEnabled = YES;
    }];
}

- (void)closeAnimation {
//    self.view.userInteractionEnabled = NO;
    //    CGFloat time = (1-fabs(self.leftVc.view.frame.origin.x / self.leftVc.view.frame.size.width))*animationTime;
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.leftVc.view.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width;
        self.leftVc.view.frame = frame;
        self.bgView.alpha = 0;
    
    } completion:^(BOOL finished) {
        //状态栏出现
//        self.hideStatusBar = NO;
//        [self.bgView removeFromSuperview];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
//            [UIView animateWithDuration:animationTime animations:^{
//                [self setNeedsStatusBarAppearanceUpdate];
//            }];
//        }
//        [KKSliderMenuTool dismiss];
        self.bgView.hidden = YES;
        self.panGestureRec.enabled = NO;

    }];
}

/**
 * 点击手势
 */
- (void)closeSideBar {
    [self closeAnimation];
}

/**
 * 拖拽手势
 */
- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes {
    
    // 下面是计算
    // 开始位置
    static CGFloat startX;
    // 结束位置
    static CGFloat lastX;
    // 改变多少
    static CGFloat durationX;
    CGPoint touchPoint = [panGes locationInView:[[UIApplication sharedApplication] keyWindow]];
    // 手势开始
    if (panGes.state == UIGestureRecognizerStateBegan) {
        startX = touchPoint.x;
        lastX = touchPoint.x;
    }
    // 手势改变
    if (panGes.state == UIGestureRecognizerStateChanged) {
        CGFloat currentX = touchPoint.x;
        durationX = currentX - lastX;
        lastX = currentX;
        CGFloat leftVcX = durationX + self.leftVc.view.frame.origin.x;
        // 如果控制器的x小于宽度直接返回
        if (leftVcX <= 100) {
            leftVcX = 100;
        }
        // 如果控制器的x大于0直接返回
        if (leftVcX >= [UIScreen mainScreen].bounds.size.width) {
            leftVcX = [UIScreen mainScreen].bounds.size.width;
        }
        // 计算bgView的透明度
        self.bgView.alpha = ((1 - (leftVcX - 100) / self.leftVc.view.frame.size.width)) * 0.5;
        // 设置左边控制器的frame
        [self.leftVc.view setFrame:CGRectMake(leftVcX, 0, self.leftVc.view.frame.size.width, self.leftVc.view.frame.size.height)];
        //        NSLog(@"%f", self.leftVc.view.frame.origin.x);
    }
    // 手势结束
    if (panGes.state == UIGestureRecognizerStateEnded) {
        // 结束为止超时屏幕一半
        if (self.leftVc.view.frame.origin.x < ([UIScreen mainScreen].bounds.size.width - 100) / 2 + 100) {
            [self showAnimation];
        } else {
            [self closeAnimation];
        }
    }
}

@end
