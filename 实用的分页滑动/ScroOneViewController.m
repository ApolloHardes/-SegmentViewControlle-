//
//  ScroOneViewController.m
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "ScroOneViewController.h"
#import "AnnouncementCell.h"
#import "NoticeModel.h"
#import "MJExtension.h"

@interface ScroOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sNewsArray;
@property (nonatomic, strong) NSMutableArray *sTeachArray;
@property (nonatomic, strong) NSMutableArray *sNoticeArray;
@property (nonatomic, strong) NSMutableArray *sCultureArray;
@property (nonatomic, strong) NSMutableArray *sMediaArray;
@end

@implementation ScroOneViewController
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title count:(NSInteger)count
{
    self = [super init];
    if (self) {
        _titleStr = title;
        _index = index;
        _count = count;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"左右滑动";
    _dataArray = [NSMutableArray new];
    _sNewsArray = [NSMutableArray new];
    _sTeachArray = [NSMutableArray new];
    _sNoticeArray = [NSMutableArray new];
    _sCultureArray = [NSMutableArray new];
    _sMediaArray = [NSMutableArray new];
    
    [self loadData];
    [self setupUI];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //_tableView.height = _tableView.height - 50 - 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"AnnouncementCell" bundle:nil] forCellReuseIdentifier:@"AnnouncementCell"];
    [self.view addSubview:_tableView];
}
- (void)loadData
{
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
   // NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Property List.plist"];
     NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSArray *ary = [usersDic objectForKey:@"resultdata"];
    for (NSDictionary *dict in ary) {
        NoticeModel *model = [NoticeModel mj_objectWithKeyValues:dict];
        if ([model.xnotice_type isEqualToString:@"sNews"]) {
            
            [_sNewsArray addObject:model];
        }else if ([model.xnotice_type isEqualToString:@"sTeach"]) {
            
            [_sTeachArray addObject:model];
        }else if ([model.xnotice_type isEqualToString:@"sNotice"]) {
            
            [_sNoticeArray addObject:model];
        }else if ([model.xnotice_type isEqualToString:@"sCulture"]) {
            
            [_sCultureArray addObject:model];
        }else if ([model.xnotice_type isEqualToString:@"sMedia"]) {
            
            [_sMediaArray addObject:model];
        }
        [self.dataArray addObject:model];
    }
    [_tableView reloadData];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_index == 0) {
        return _sNoticeArray.count;
    }else if (_index == 1){
        return _sTeachArray.count;
    }else if (_index == 2){
        return _sNewsArray.count;
        
    }else if (_index == 3){
        return _sCultureArray.count;
    }
    return _sMediaArray.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnouncementCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_index == 0) {
        
        NoticeModel *model = self.sNoticeArray[indexPath.section];
        [cell setModel:model];
        
    }else if(_index ==1 ){
        
        NoticeModel *model = self.sTeachArray[indexPath.section];
        [cell setModel:model];
        
    }else if(_index ==2 ){
        NoticeModel *model = self.sNewsArray[indexPath.section];
        [cell setModel:model];
        
        
    }else if(_index ==3 ){
        
        NoticeModel *model = self.sCultureArray[indexPath.section];
        [cell setModel:model];
    }else if(_index ==4 ){
        
        NoticeModel *model = self.sMediaArray[indexPath.section];
        [cell setModel:model];
    }
    return cell;
}
#pragma mark -- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"每天都要开心哦😊");
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
