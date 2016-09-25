//
//  RequestModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "RequestModule.h"
#import "LocationModule.h"

// @"http://192.168.116.158:8080"

#define DOMAIN @"http://fd25b0f9.ngrok.io"

@implementation RequestModule

// shared module for use in other classes
+ (RequestModule *)sharedModule {
    static RequestModule *module = nil;
    if (!module) {
        module = [[self alloc] init];
    }
    return module;
}



// sends pingInfo to server and receives corresponding JSON obj
- (void) pingInfo: (NSInteger) userID andGroupID: (NSInteger) groupID andReturningData:(void(^)(NSDictionary*))callback
{
    // initializes location module object
    LocationModule * module = [LocationModule sharedModule];
    
    // creates dictionary obj and returns it
    NSDictionary *dict = @{
                           @"id": @(userID),
                           @"group_id": @(groupID),
                           @"latitude": @(module.latitude),
                           @"longitude": @(module.longitude),
                           @"precision": @(module.uncertaintyRadius),
                           @"speed": @(module.speed),
                           @"direction": @(module.direction),
                           @"locations": @(1)
                           };
    

    
    // set url - .../create
    NSURL *url = [NSURL URLWithString:DOMAIN @"/ping"];

    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];

    // sends join Group info to server and does something with returned dictionary obj (undecided)
    [temp sendServerInfo:dict andURL:url andReturningData:callback];


}

// sends createGroupInfo to server and receives corresponding JSON obj
-(void) createGroupInfo: (NSString*) groupName andTeams: (NSInteger) teams andReturningData:(void(^)(NSDictionary*))callback{
    
    // creates dictionary obj and returns it
    NSDictionary *dict = @{
                           @"name": groupName,
                           @"teams": @(teams)
                           };
    // set url - .../create
    NSURL *url = [NSURL URLWithString:DOMAIN @"/create"];

    
    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];
    
    // sends join Group info to server and does something with returned dictionary obj (undecided)
    [temp sendServerInfo:dict andURL:url andReturningData:callback];
}

// sends joinGroupInfo to server and receives corresponding JSON obj
-(void) joinGroupInfo: (NSInteger) groupID andTeam: (NSInteger) team andReturningData:(void(^)(NSDictionary*))callback{
    // creates dictionary obj and returns it
    NSDictionary *dict = @{
                           @"group_id": @(groupID),
                           @"team": @(team)
                           };
    // set url - .../join
    NSURL *url = [NSURL URLWithString:DOMAIN @"/join"];
    
    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];
    
    // sends join Group info to server and does something with returned dictionary obj (undecided)
    [temp sendServerInfo:dict andURL:url andReturningData:callback];
}

// returns a mutable dictionary of the different groups and number of teams in each group
- (void) getGroupInfoReturningData:(void(^)(NSDictionary*))callback
{
    // set url - .../groups
    NSURL *url = [NSURL URLWithString:DOMAIN @"/groups"];
    [self sendServerInfo:@{} andURL:url andReturningData:callback];
}

//connects to server - sends appropriate JSON object and receives corresponding info in a callback function
- (void) sendServerInfo:(NSDictionary*) data andURL: (NSURL*) url andReturningData:(void(^)(NSDictionary*))callback
{
    // creates JSON data objct
    // data with JSON object: converting dictionary obj --> string of bits (NSData)
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    
    // configures NSURL session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // creates NSURL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL: url];
    
    // sets method type and body
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    // sends the data
    if (!error)
    {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:jsonData completionHandler:^(NSData *responseData,NSURLResponse *response,NSError *error) {
                                                                       // creates returning JSON data objct
                                                                       NSError *rerror = nil;
                                                                       if (responseData == nil)
                                                                       {
                                                                           callback(nil);
                                                                       }
                                                                       else{
                                                                           NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&rerror];
                                                                           callback(responseJSON);
                                                                       }
                                                                       

                                                                   }];
        [uploadTask resume];
        
    }
    
    
}




@end
