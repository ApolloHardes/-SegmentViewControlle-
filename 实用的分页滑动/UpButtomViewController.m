//
//  UpButtomViewController.m
//  实用的分页滑动
//
//  Created by Apollo on 17/6/15.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "UpButtomViewController.h"
#import "SegmentViewController.h"
#import "ScroTwoViewController.h"
static CGFloat const ButtonHeight = 50;
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height

@interface UpButtomViewController ()

@end

@implementation UpButtomViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"上下滑动";
    [self createUI];
    [super viewDidLoad];

}
-(void)createUI{
    SegmentViewController *vc = [[SegmentViewController alloc]init];
    vc.HorW = @"H";
    NSArray *titleArray = @[@"通知公告", @"教务通知", @"学校要闻", @"文化学术", @"媒体视角"];
    vc.titleArray = titleArray;
    NSMutableArray *controlArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < vc.titleArray.count; i ++) {
        ScroTwoViewController *vc = [[ScroTwoViewController alloc]initWithIndex:i title:titleArray[i] count:titleArray.count];
        [controlArray addObject:vc];
    }
    vc.subViewControllers = controlArray;
    vc.buttonWidth = 80;
    vc.buttonHeight = ButtonHeight;
    [vc initSegment];
    [vc addParentController:self];
    //[vc addParentController:self];[vc.mainScrollView setContentOffset:CGPointMake(0, MainScreenHeight*_week.intValue) animated:NO ];
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
