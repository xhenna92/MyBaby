//
//  Event.h
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface Event : PFObject <PFSubclassing>

@property (nonatomic) NSString * eventDate;
@property (nonatomic) NSString * childID;
@property (nonatomic) NSString * eventName;
@property (nonatomic) NSString * eventDescription;
@property (nonatomic) double eventCoordinateLat;
@property (nonatomic) double eventCoordinatelng;

@end
