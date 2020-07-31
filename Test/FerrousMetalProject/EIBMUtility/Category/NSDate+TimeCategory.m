//
//  NSDate+TimeCategory.m
//  ACSM_farming
//
//  Created by xstone on 15/11/3.
//  Copyright © 2015年 xstone. All rights reserved.
//

#import "NSDate+TimeCategory.h"
static NSDateFormatter *dateFormatter;

@implementation NSDate (TimeCategory)

+(NSDateFormatter *)defaultFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

+ (NSInteger)cTimestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}


+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}

+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}

+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [NSDate defaultFormatter];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger dateNum = [NSDate cTimestampFromString:[NSDate dateStrFromCstampTime:interval withDateFormat:@"yyyy-MM-dd"] format:@"yyyy-MM-dd"];
    NSString *firstYear = [NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"yyyy"];
    NSString *secondYear = [NSDate dateStrFromCstampTime:interval withDateFormat:@"yyyy"];
    if([firstYear isEqualToString:secondYear]){
        if(dateNum < timeStamp){
            NSInteger num = (timeStamp - dateNum)/3600;
            if(num < 12){
                return [NSString stringWithFormat:@"上午%@",[NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"HH:mm"]];
            }else{
                return [NSString stringWithFormat:@"下午%@",[NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"HH:mm"]];
            }
        }else{//不在今天
            NSInteger num = (dateNum - timeStamp)/3600;
            if(num < 24){
                return [NSString stringWithFormat:@"昨天%@",[NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"HH:mm"]];
            }else{
                return [NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"MM月dd日"];
            }
        }
    }
    return [NSDate dateStrFromCstampTime:timeStamp withDateFormat:@"yyyy年MM月dd日"];
}

- (long int)utcTimeStamp{
    return lround(floor([self timeIntervalSince1970]));
}

@end
