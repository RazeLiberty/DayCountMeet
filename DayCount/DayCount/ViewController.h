//
//  ViewController.h
//  DayCount
//
//  Created by Takehiro Kawahara on 2014/11/26.
//  Copyright (c) 2014年 Takehiro Kawahara. All rights reserved.
//

#import <UIKit/UIKit.h>

//delegateプロトコル指定
@interface ViewController : UIViewController <UITextFieldDelegate> //For push return to close keyboard

@end


@interface DateUtility: NSObject

+ (NSDate*)adjustZeroClock:(NSDate*)date withCalendar:(NSCalendar*)calendar;
+ (NSInteger*)daysBetween:(NSDate*)startDate and:(NSDate*)endDate;

@end

