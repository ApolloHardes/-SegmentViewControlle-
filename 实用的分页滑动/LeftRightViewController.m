//
//  LeftRightViewController.m
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "LeftRightViewController.h"
#import "SegmentViewController.h"
#import "ScroOneViewController.h"
static CGFloat const ButtonHeight = 50;

@interface LeftRightViewController ()

@end

@implementation LeftRightViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"左右滑动";
    [self createUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createUI{
   // self.currenPage = 1;
    SegmentViewController *vc = [[SegmentViewController alloc]init];
    //通过vc.HorW来判断是左右滑动还是上下滑动
    vc.HorW = @"W";
    NSArray *titleArray = @[@"通知公告", @"教务通知", @"学校要闻", @"文化学术", @"媒体视角"];
    vc.titleArray = titleArray;
    NSMutableArray *controlArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < vc.titleArray.count; i ++) {
        ScroOneViewController *vc = [[ScroOneViewController alloc]initWithIndex:i title:titleArray[i] count:titleArray.count];
        [controlArray addObject:vc];
    }
    vc.subViewControllers = controlArray;
    vc.buttonWidth = 80;
    vc.buttonHeight = ButtonHeight;
    [vc initSegment];
    [vc addParentController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
