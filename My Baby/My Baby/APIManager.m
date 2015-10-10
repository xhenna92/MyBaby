//
//  APIManager.m
//  LearnAPIs
//
//  Created by Henna on 9/20/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (void) GETRequestWithURL:(NSURL *) URL completionHandler:(void(^)(NSData *, NSURLResponse *, NSError *)) completionHandler {
    //Create a session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data, response, error);
        });
    }];
    
    [dataTask resume];
    
}

@end
