//
//  NSDate+LCExtend.h
//  授权机制
//
//  Created by Apollo on 16/3/17.
//  Copyright (c) 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCExtend)
/**
 *  是否是今天
 */
- (BOOL)isToday;
/**
 *  是否是昨天
 */
- (BOOL)isYesterday;
/**
 *  是否是今年
 */
- (BOOL)isThisYear;

/**
 *  获取与当前时间的差距
 */
- (NSDateComponents *)deltaToNow;
@end
