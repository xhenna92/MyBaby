//
//  Event.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "Event.h"

@implementation Event

@dynamic  eventDate;
@dynamic  childID;
@dynamic  eventName;
@dynamic  eventDescription;

+ (NSString *) parseClassName {
    return @"Event";
}

@end
