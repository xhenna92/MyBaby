//
//  Child.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "Child.h"

@implementation Child
@dynamic parentID;
@dynamic childID;
@dynamic childName;
@dynamic childGender;
@dynamic childDOB;
@dynamic childWeight;
@dynamic childHeightFT;
@dynamic childHeightIN;
@dynamic childLullaby;
@dynamic childDescription;

+ (NSString *) parseClassName {
    return @"Child";
}
@end
