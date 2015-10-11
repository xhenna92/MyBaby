//
//  EventsCalendarViewController.h
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JTCalendar/JTCalendar.h>

@interface EventsCalendarViewController : UIViewController <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;


@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
