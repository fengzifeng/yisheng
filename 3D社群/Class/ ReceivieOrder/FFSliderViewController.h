//
//  FFSliderViewController.h
//  3D社群
//
//  Created by fengzifeng on 2017/11/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "MCViewController.h"

@interface FFSliderViewController : MCViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController contentViewController:(UIViewController *)leftVc;

@property (nonatomic, assign) BOOL hideStatusBar;//隐藏状态栏
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, assign) BOOL hasShow;

@end
