//
//  SegmentViewController.m
//  SegmentView
//
//  Created by Apollo on 17/5/6.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "SegmentViewController.h"
#import "NoticeModel.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define PREFIX @"https://lehuocampus.cn/"
//公告模块：notice
#define Notice_Url [NSString stringWithFormat:@"%@xyx/notice?",PREFIX]


#define HEADBTN_TAG                 10000
#define Default_BottomLineColor     [UIColor colorWithRed:51/255.0 green:109/255.0 blue:205/255.0 alpha:1]
#define Default_BottomLineHeight    2
#define Default_ButtonHeight        45
#define buttonH  (MainScreenHeight - 64) / 7
#define buttonW  100
#define Default_TitleColor          [UIColor blackColor]
#define Default_HeadViewBackgroundColor  [UIColor whiteColor]
#define Default_FontSize            16
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height

@interface SegmentViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *headerView;

@property (nonatomic, strong) UIView *lineView;


@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //[_mainScrollView scrollRectToVisible:CGRectMake(0,_selectIndex, buttonW, _headerView.frame.size.height) animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSegment
{
    if ([_HorW isEqualToString:@"W"]) {
        [self addButtonInScrollHeader:_titleArray];
        [self addContentViewScrollView:_subViewControllers];
    }else
    {
        [self addButtonInScrollHeaders:_titleArray :_dataArray];
        [self addContentViewScrollViews:_subViewControllers];
    }
    
}

/*!
 *  @brief  根据传入的title数组新建button显示在顶部scrollView上
 *
 *  @param titleArray  title数组
 */
- (void)addButtonInScrollHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, 0, MainScreenWidth, self.buttonHeight);
    if (_segmentHeaderType == 0) {
        self.headerView.contentSize = CGSizeMake(self.buttonWidth * titleArray.count, self.buttonHeight);
    }
    else {
        self.headerView.contentSize = CGSizeMake(MainScreenWidth, self.buttonHeight);
    }
    [self.view addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(self.buttonWidth * index, 0, self.buttonWidth, self.buttonHeight);
        [segmentBtn setTitle:titleArray[index] forState:UIControlStateNormal];
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        segmentBtn.tag = index + HEADBTN_TAG;
        [segmentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [segmentBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:segmentBtn];
        if (index == 0) {
            segmentBtn.selected = YES;
            self.selectIndex = segmentBtn.tag;
        }
    }
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonHeight - self.bottomLineHeight, self.buttonWidth, self.bottomLineHeight)];
    _lineView.backgroundColor = self.bottomLineColor;
    [self.headerView addSubview:_lineView];
}
- (void)addButtonInScrollHeaders:(NSArray *)titleArray:(NSArray *)dataAry
{
    self.headerView.frame = CGRectMake(0, 0, buttonW, SCREEN_H);
    self.headerView.backgroundColor = [self colorWithHexString:@"#f2f2f2"];
    if (_segmentHeaderType == 0) {
        self.headerView.contentSize = CGSizeMake(buttonW,buttonH*titleArray.count);
    }
    else {
        self.headerView.contentSize = CGSizeMake(buttonW,buttonH*titleArray.count);
    }
    [self.view addSubview:self.headerView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(0, buttonH*index, buttonW, buttonH);
        //[segmentBtn.layer setBorderWidth:0.5];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, buttonH/2-20, buttonW, 20)];
        lable.text =titleArray[index];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:self.fontSize];
        [segmentBtn addSubview:lable];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonH-1, buttonW, 1)];
        lineView.backgroundColor = [self colorWithHexString:@"#d6d6d6"];
        [segmentBtn addSubview:lineView];
        
        segmentBtn.tag = index + HEADBTN_TAG;
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [segmentBtn setBackgroundImage:[UIImage imageNamed:@"Button灰色.png"] forState:UIControlStateNormal];
        [segmentBtn setBackgroundImage:[UIImage imageNamed:@"Button白色.png"] forState:UIControlStateSelected];
        UILabel *dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, buttonH/2+10, buttonW, 20)];
        dataLabel.text = dataAry[index];
        dataLabel.textAlignment = NSTextAlignmentCenter;
        dataLabel.font = [UIFont systemFontOfSize:self.fontSize];
        [segmentBtn addSubview:dataLabel];
        
        [self.headerView addSubview:segmentBtn];
        
        if (index == _selectIndex) {
            segmentBtn.selected = YES;
            segmentBtn.tag = index + HEADBTN_TAG;
            self.selectIndex = segmentBtn.tag;
        }
    }

}
/*!
 *  @brief  根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
 *
 *  @param button  viewController数组
 */

- (void)addContentViewScrollView:(NSArray *)subViewControllers
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, MainScreenWidth, MainScreenHeight - self.buttonHeight)];
    _mainScrollView.contentSize = CGSizeMake(MainScreenWidth * subViewControllers.count, MainScreenHeight - self.buttonHeight);
    [_mainScrollView setPagingEnabled:YES];
    if (_segmentControlType == 0) {
        _mainScrollView.scrollEnabled = YES;
    }
    else {
        _mainScrollView.scrollEnabled = NO;
    }
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    [subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
       
        viewController.view.frame = CGRectMake(idx * MainScreenWidth, 0, MainScreenWidth, _mainScrollView.frame.size.height);
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}
- (void)addContentViewScrollViews:(NSArray *)subViewControllers
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 0, MainScreenWidth-100, MainScreenHeight)];
    _mainScrollView.contentSize = CGSizeMake(MainScreenWidth-100, MainScreenHeight*subViewControllers.count);
    [_mainScrollView setPagingEnabled:YES];
    if (_segmentControlType == 0) {
        _mainScrollView.scrollEnabled = YES;
    }
    else {
        _mainScrollView.scrollEnabled = NO;
    }
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    [subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        
        viewController.view.frame = CGRectMake(0, idx * MainScreenHeight, MainScreenWidth, MainScreenHeight);
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
}

- (void)addParentController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)btnClick:(UIButton *)button
{
    if ([_HorW isEqualToString:@"W"]) {
        [_mainScrollView scrollRectToVisible:CGRectMake((button.tag - HEADBTN_TAG) *MainScreenWidth, 0, MainScreenWidth, _mainScrollView.frame.size.height) animated:YES];
        [self didSelectSegmentIndex:button.tag];
    }else
    {
        [_mainScrollView scrollRectToVisible:CGRectMake(0, (button.tag - HEADBTN_TAG) *MainScreenHeight, MainScreenWidth-100, _mainScrollView.frame.size.height) animated:YES];
        
        [self didSelectSegmentIndex:button.tag];
    }
    
}

/*!
 *  @brief  设置顶部选中button下方线条位置
 *
 *  @param index 第几个
 */
- (void)didSelectSegmentIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    self.selectIndex = index;
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
    CGRect rect = self.lineView.frame;
    rect.origin.x = (index - HEADBTN_TAG) * _buttonWidth;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = rect;
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.HorW isEqualToString:@"W"]) {
        if (scrollView == _mainScrollView) {
            float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
            [_headerView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headerView.frame.size.height) animated:YES];
            NSInteger currentIndex = scrollView.contentOffset.x / MainScreenWidth;
            [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
        }
    }else
    {
        if (scrollView == _mainScrollView) {
            float xx = scrollView.contentOffset.y * (buttonH / MainScreenHeight) - buttonH;
            [_headerView scrollRectToVisible:CGRectMake(0,xx, buttonW, _headerView.frame.size.height) animated:YES];
            NSInteger currentIndex = scrollView.contentOffset.y / MainScreenHeight;
            [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
        }

    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    if ([_HorW isEqualToString:@"W"]) {
        float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
        [_headerView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headerView.frame.size.height) animated:YES];
    }else
    {
        float xx = scrollView.contentOffset.y * (buttonH / MainScreenHeight) - buttonH;
        [_headerView scrollRectToVisible:CGRectMake(0,xx, buttonW, _headerView.frame.size.height) animated:YES];
        //[scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_W, xx*SCREEN_H) animated:YES];
    }
    
}

#pragma mark - setter/getter
- (UIScrollView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIScrollView alloc] init];
        [_headerView setShowsVerticalScrollIndicator:NO];
        [_headerView setShowsHorizontalScrollIndicator:NO];
        _headerView.bounces = NO;
        _headerView.backgroundColor = self.headViewBackgroundColor;
    }
    return _headerView;
}

- (UIColor *)headViewBackgroundColor
{
    if (_headViewBackgroundColor == nil) {
        _headViewBackgroundColor = Default_HeadViewBackgroundColor;
    }
    return _headViewBackgroundColor;
}

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        _titleColor = Default_TitleColor;
    }
    return _titleColor;
}

- (UIColor *)titleSelectedColor
{
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = Default_TitleColor;
    }
    return _titleSelectedColor;
}

- (CGFloat)fontSize
{
    if (_fontSize == 0) {
        _fontSize = Default_FontSize;
    }
    return _fontSize;
}

- (CGFloat)buttonWidth
{
    if (_buttonWidth == 0) {
        _buttonWidth = MainScreenWidth / 6;
    }
    return _buttonWidth;
}

- (CGFloat)buttonHeight
{
    if (_buttonHeight == 0) {
        _buttonHeight = Default_ButtonHeight;
    }
    return _buttonHeight;
}

- (CGFloat)bottomLineHeight
{
    if (_bottomLineHeight == 0) {
        _bottomLineHeight = Default_BottomLineHeight;
    }
    return _bottomLineHeight;
}

- (UIColor *)bottomLineColor
{
    if (_bottomLineColor == nil) {
        _bottomLineColor = Default_BottomLineColor;
    }
    return _bottomLineColor;
}
- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
    
    return nil;
}


@end
