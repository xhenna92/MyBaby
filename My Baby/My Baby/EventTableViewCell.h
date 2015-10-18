//
//  EventTableViewCell.h
//  My Baby
//
//  Created by Henna on 10/17/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDayLabel;

@end
