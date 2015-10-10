//
//  APIManager.h
//  LearnAPIs
//
//  Created by Henna on 9/20/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void) GETRequestWithURL:(NSURL *) URL completionHandler:(void(^)(NSData *, NSURLResponse *, NSError *)) completionHandler;

@end
