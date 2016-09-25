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

// shared module for use in other classes
+ (RequestModule *)sharedModule {
    static RequestModule *module = nil;
    if (!module) {
        module = [[self alloc] init];
    }
    return module;
}

// returns NSDictionary object with info needed for a ping to the server
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
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8082/ping"];

    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];

    // sends join Group info to server and saves responding JSON
    [temp sendServerInfo:dict andURL:url andReturningData:callback];


}

// returns NSDictionary object with info needed to create Group
-(void) createGroupInfo: (NSString*) groupName andTeams: (NSInteger) teams andReturningData:(void(^)(NSDictionary*))callback{
    
    // creates dictionary obj and returns it
    NSDictionary *dict = @{
                           @"name": groupName,
                           @"teams": @(teams)
                           };
    // set url - .../create
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8081/create"];
    
    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];
    
    // sends join Group info to server and saves responding JSON
    [temp sendServerInfo:dict andURL:url andReturningData:^(NSDictionary *returningData) {
        //TODO: save the info somewhere!
        NSLog(@"successfully saved CREATE GROUP info technically");
    }];
    
}

// returns NSDictionary object with info needed to join Group -
-(void) joinGroupInfo: (NSInteger) groupID andTeam: (NSInteger) team andReturningData:(void(^)(NSDictionary*))callback{
    // creates dictionary obj and returns it
    NSDictionary *dict = @{
                           @"group_id": @(groupID),
                           @"team": @(team)
                           };
    // set url - .../join
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/join"];
    
    // instantiate requestModule obj
    RequestModule* temp = [RequestModule sharedModule];
    
    // sends join Group info to server and saves responding JSON
    [temp sendServerInfo:dict andURL:url andReturningData:^(NSDictionary *returningData) {
        //TODO: save the info somewhere!
        NSLog(@"successfully saved JOIN GROUP info technically");
    }];
    
    
}
//connects to server - sends appropriate JSON object and receives corresponding info as a callback function
- (void) sendServerInfo:(NSDictionary*) data andURL: (NSURL*) url andReturningData:(void(^)(NSDictionary*))callback
{
    // creates JSON data objct
    // data with JSON object: converting dictionary obj --> string of bits (NSData)
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    
    // configures NSURL session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // creates NSURL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL: url];
    
    // sets method type and body
    [request setHTTPMethod:@"POST"];
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
