//
//  RequestModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "RequestModule.h"
#import "LocationModule.h"

@implementation RequestModule


+ (RequestModule *)sharedModule {
    static RequestModule *module = nil;
    if (!module) {
        module = [[self alloc] init];
    }
    return module;
}


// send and receive JSON function, pass in a dictionary and a url -

- (void) connectBackEnd: (NSInteger) userID andGroupID: (NSInteger) groupID
{
    // configures NSURL session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // creates NSURL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://127.0.0.1:8080"]];
    
    
    // initializes location module object
    LocationModule * module = [LocationModule sharedModule];
    
    // initializes NSDictionary object to use for creating a JSON
    NSMutableDictionary *dict= [@{
                                  @"user_ID" : @(userID),
                                  @"group_ID" : @(groupID),
                                  @"latitude" : @(module.latitude),
                                  @"longitude" : @(module.longitude),
                                  @"uncertaintyRadius" : @(module.uncertaintyRadius),
                                  @"speed" : @(module.speed),
                                  @"direction": @(module.direction),
                                  @"location" : @(1)
                                  }mutableCopy];
    
    // creates JSON data object
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    // sets method type and body
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    // sends the data
    if (!error)
    {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                  fromData:jsonData completionHandler:^(NSData *responseData,NSURLResponse *response,NSError *error) {
                                                                      // Handle response here
                                                                  }];
        [uploadTask resume];
        
    }

    
}



@end
