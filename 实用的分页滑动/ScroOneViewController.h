//
//  ScroOneViewController.h
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScroOneViewController : UIViewController
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title count:(NSInteger)count;
@property (nonatomic, strong) NSMutableArray *dataAry;
@end
