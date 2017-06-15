//
//  NoticeModel.h
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SF_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
@interface NoticeModel : NSObject
@property (nonatomic, copy) NSString *article_type;
@property (nonatomic, copy) NSString *xnotice_type;
@property (nonatomic, copy) NSString *xnotice_title;
@property (nonatomic, copy) NSString *xnotice_content_intro;
@property (nonatomic, copy) NSString *xnotice_date;


@end
