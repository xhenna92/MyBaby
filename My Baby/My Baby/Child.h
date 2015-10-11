//
//  Child.h
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFObject.h"

@interface Child : PFObject <PFSubclassing>

@property (nonatomic) NSString * parentID;
@property (nonatomic) NSString * childID;
@property (nonatomic) NSString * childName;
@property (nonatomic) BOOL childGender;
@property (nonatomic) NSString * childDOB;
@property (nonatomic) NSNumber * childWeight;
@property (nonatomic) NSNumber * childHeightFT;
@property (nonatomic) NSNumber * childHeightIN;
@property (nonatomic) NSString * childLullaby;
@property (nonatomic) NSString * childDescription;

@end
