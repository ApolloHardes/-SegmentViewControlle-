# -
封装的scrollview+tableview实现左右分页滑动和上下分页滑动,菜单分页,通过头部点击或者页面滑动轻松实现多界面
=====
封装的SegmentViewController中根据传入的_HorW来判断创建一个上下滑动的还是左右滑动的分页界面,demo里面已经写了上下滑动和左右滑动两种
-------
demo中我建了一个plist文件来提供简单数据,封装的AnnouncementCell和NoticeModel.UpButtomViewController和LeftRightViewController是两个滑动界面都是调用了SegmentViewController的方法,通过给他传入一个titleArray数组来判断创建几个分页,添加子
```
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
```
