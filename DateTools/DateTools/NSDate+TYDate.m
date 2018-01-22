//
//  NSDate+TYDate.m
//  DateToolsExample
//
//  Created by fanrong on 2018/1/22.
//

#import "NSDate+TYDate.h"

@implementation NSDate (TYDate)

- (NSDate *)converDateToDayBegin:(NSDate *)date {
    NSDate *fromDate = [NSDate dateWithYear:date.year month:date.month day:date.day hour:0 minute:0 second:0];
    return fromDate;
}

- (NSDate *)converDateToDayEnd:(NSDate *)date {
    NSDate *toDate = [NSDate dateWithYear:date.year month:date.month day:date.day hour:23 minute:59 second:59];
    return toDate;
}
- (NSDate *)converDateToWeekBegin:(NSDate *)date {
    return [self getWeekOnDate:date].StartDate;
}
- (NSDate *)converDateToWeekEnd:(NSDate *)date {
    return [self getWeekOnDate:date].EndDate;
}

- (NSDate *)converDateToMonthBegin:(NSDate *)date {
    NSDate *fromDate = [NSDate dateWithYear:date.year month:date.month day:1 hour:0 minute:0 second:0];
    return fromDate;
}

- (NSDate *)converDateToMonthEnd:(NSDate *)date {
    NSDate *fromDate = [NSDate dateWithYear:date.year month:date.month + 1 day:1 hour:0 minute:0 second:0];
    NSDate *toDate = [fromDate dateBySubtractingSeconds:1];
    return toDate;
}

+ (BOOL)isCurWeekWithDate:(NSDate *)date {
    NSDate *weekBegin = [self converDateToWeekBegin:[NSDate date]];
    NSDate *weekEnd = [self converDateToWeekEnd:[NSDate date]];
    if ([date isEqualToDate:weekBegin] || [date isEqualToDate:weekEnd]) {
        return YES;
    }
    DTTimePeriod *time = [[DTTimePeriod alloc] initWithStartDate:weekBegin endDate:weekEnd];
    if ([time containsDate:date interval:0.0]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isCurMonthWithDate:(NSDate *)date {
    NSDate *monthBegin = [self converDateToMonthBegin:[NSDate date]];
    NSDate *monthEnd = [self converDateToMonthEnd:[NSDate date]];
    if ([date isEqualToDate:monthBegin] || [date isEqualToDate:monthEnd]) {
        return YES;
    }
    DTTimePeriod *time = [[DTTimePeriod alloc] initWithStartDate:monthBegin endDate:monthEnd];
    if ([time containsDate:date interval:0.0]) {
        return YES;
    }
    return NO;
}

#pragma mark 天数
+ (NSArray <NSDate *>*)getDayDataOnLeftDate:(NSDate *)leftDate {
    NSMutableArray <NSDate *>*timeArr = [[NSMutableArray <NSDate *> alloc] init];
    
    NSDate *curDate = [NSDate new];
    
    NSArray <NSDate *>*beforeTimeArr = [self addDayBeforeWithLeftDate:leftDate];
    NSArray <NSDate *>*contentTimeArr = [self addLeftDate:leftDate untilCurDate:curDate];
    NSArray <NSDate *>*futrueTimeArr = [self addDayFutrueWithCurDate:curDate];
    
    [timeArr addObjectsFromArray:beforeTimeArr];
    [timeArr addObjectsFromArray:contentTimeArr];
    [timeArr addObjectsFromArray:futrueTimeArr];
    
    return [timeArr copy];
}

+ (NSArray <NSDate *>*)addLeftDate:(NSDate *)leftDate untilCurDate:(NSDate *)curDate {
    NSMutableArray <NSDate *>*timeArr = [[NSMutableArray <NSDate *> alloc] init];
    
    [timeArr addObject:[curDate copy]];
    NSDate *curDateCopy = [curDate dateBySubtractingDays:1];
    while ([curDateCopy isLaterThanOrEqualTo:leftDate]) {
        [timeArr addObject:curDateCopy];
        curDateCopy = [curDateCopy dateBySubtractingDays:1];
    }
    
    return [[self reverseTimeArr:timeArr] copy];
}

+ (NSArray <NSDate *>*)addDayBeforeWithLeftDate:(NSDate *)leftDate {
    NSMutableArray <NSDate *>*timeArr = [[NSMutableArray <NSDate *> alloc] init];
    
    for (NSInteger i = 1; i <= 3; i++) {
        [timeArr addObject:[[leftDate copy] dateBySubtractingDays:i]];
    }
    return [[self reverseTimeArr:timeArr] copy];
}

+ (NSArray <NSDate *>*)addDayFutrueWithCurDate:(NSDate *)curDate {
    NSMutableArray <NSDate *>*timeArr = [[NSMutableArray <NSDate *> alloc] init];
    
    for (NSInteger i = 1; i <= 3; i++) {
        [timeArr addObject:[[curDate copy] dateByAddingDays:i]];
    }
    return [timeArr copy];
}


#pragma mark 月

+ (NSArray <NSDate *>*)getMonthOnLeftDate:(NSDate *)leftDate {
    NSMutableArray <NSDate *>*timeArr = [[NSMutableArray <NSDate *> alloc] init];
    
    NSDate *curDate = [NSDate new];
    curDate = [NSDate dateWithYear:curDate.year month:curDate.month day:1 hour:0 minute:0 second:0];
    
    leftDate = [NSDate dateWithYear:leftDate.year month:leftDate.month day:1 hour:0 minute:0 second:0];
    
    for (NSInteger i = 0;i < 3; i++) {
        NSDate *date = [leftDate dateBySubtractingMonths:i];
        [timeArr addObject:date];
    }
    timeArr = [self reverseTimeArr:timeArr];
    
    NSInteger monthCount = 0;
    while ([leftDate isEarlierThan:curDate]) {
        leftDate = [leftDate dateByAddingMonths:1];
        monthCount += 1;
    }
    
    NSMutableArray *contentDateArr = [NSMutableArray array];
    for (NSInteger i = 0; i < monthCount; i++) {
        NSDate *date = [curDate dateBySubtractingMonths:i];
        [contentDateArr addObject:date];
    }
    [timeArr addObjectsFromArray:[self reverseTimeArr:contentDateArr]];
    
    for (NSInteger i = 1; i<= 3; i++) {
        NSDate *date = [curDate dateByAddingMonths:i];
        [timeArr addObject:date];
    }
    
    return [timeArr copy];
}


@end
