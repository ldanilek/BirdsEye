//
//  RequestModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "RequestModule.h"

@implementation RequestModule

// creates a JSON object to be passed to the back-end
//optional parameters: speed and direction but if have one, need to include the others
- (NSData *) createJSONObject: (NSInteger) user_id andgroup_id: (NSInteger) group_id andlat: (double) latitude andlong: (double) longitude andprecision: (double) precision andspeed: (double) speed anddirection: (double) direction andloc: (NSNumber*) location
{
    //TODO: use the shared moduel to call Lee's method instead of passing it all in the method parameters
    NSMutableDictionary *dict= [@{
                                 @"user_ID" : @(user_id),
                                 @"group_ID" : @(group_id),
                                 @"latitude" : @(latitude),
                                 @"longitude" : @(longitude),
                                 @"precision" : @(precision),
                                 @"speed" : @(speed),
                                 @"direction": @(direction),
                                 @"location" : location
                                 }mutableCopy];
    
    
    
    
}


// sets post string
//NSString *post = [NSString stringWithFormat:@"&Latitude=%@&Longitude=%@",@"latitude",@"longitude"];


// URL request
// function that has all those data parameters
// builds a JSON through a library Json object - NSJONserializer!!! everything is going to be in doubles/ strings, id, group, etc

/* J.setid = blahs */
// body or payload
/*NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"tobefilledinlater"]];


// sets the HTTP method as post
[request setHTTPMethod:@"POST"];
[request setValue:@"possibleJSONobject?" forHTTPHeaderField:@"Content-type"]; */



@end
