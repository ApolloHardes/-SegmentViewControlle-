//
//  ViewController.m
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "ViewController.h"
#import "LeftRightViewController.h"
#import "UpButtomViewController.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏navigationBar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"首页-渐变_01.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    //设置系统返回箭头的颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    
    //创建导航栏左边按钮
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"左右" style:UIBarButtonItemStyleDone target:self action:@selector(touchOneBut)];
    self.navigationItem.leftBarButtonItem = leftItem;
      //创建导航栏右边按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"上下" style:UIBarButtonItemStyleDone target:self action:@selector(touchTwoBut)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)touchOneBut
{
    LeftRightViewController *leftRighrVC = [[LeftRightViewController alloc]init];
    [self.navigationController pushViewController:leftRighrVC animated:YES];
}
- (void)touchTwoBut
{
    UpButtomViewController *scroTwoVC= [[UpButtomViewController alloc]init];
    [self.navigationController pushViewController:scroTwoVC animated:YES];
}


@end
