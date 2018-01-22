//
//  NSDate+TYDate.h
//  DateToolsExample
//
//  Created by fanrong on 2018/1/22.
//

#import <Foundation/Foundation.h>

@interface NSDate (TYDate)
// 一天的开始 0：00 结束 23：59
- (NSDate *)converDateToDayBegin:(NSDate *)date;
- (NSDate *)converDateToDayEnd:(NSDate *)date;

// 一周的开始 星期一，一周的结束 星期日
- (NSDate *)converDateToWeekBegin:(NSDate *)date;
- (NSDate *)converDateToWeekEnd:(NSDate *)date;

// 一个月的开始，一个月的结束
- (NSDate *)converDateToMonthBegin:(NSDate *)date;
- (NSDate *)converDateToMonthEnd:(NSDate *)date;

// 日期是否是本周内（周一到周日为一周）
+ (BOOL)isCurWeekWithDate:(NSDate *)date;
// 日期是否是本月内
+ (BOOL)isCurMonthWithDate:(NSDate *)date;

// 获取当前时间到leftDate 之前的时间(按周计算)
+ (NSArray <NSDate *>*)getWeekDataOnLeftDate:(NSDate *)leftDate;

// 获取当前时间到leftDate 之前的时间(按天计算)
+ (NSArray <NSDate *>*)getDayDataOnLeftDate:(NSDate *)leftDate;

// 获取当前时间到leftDate 之前的时间(按月计算)
+ (NSArray <NSDate *>*)getMonthOnLeftDate:(NSDate *)leftDate;


@end
