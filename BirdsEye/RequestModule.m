//
//  RequestModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "RequestModule.h"

@implementation RequestModule

- (NSData *) createJSONObject: (NSInteger) user_id andgroup_id: (NSInteger) group_id andlat: (NSSwappedDouble) latitude andlong: (NSSwappedDouble) longitude andprecision: (NSSwappedDouble) precision andspeed: (NSSwappedDouble) speed anddirection: (NSSwappedDouble) direction andloc: (NSNumber*) location
{

    NSDictionary *dict= @{
                                 @"user_ID" : @(user_id),
                                 @"group_ID" : @(group_id),
                                 @"latitude" : @(latitude),
                                 @"longitude" : @longitude,
                                 @"precision" : @longitude,
                                 @"speed" : speed,
                                 @"direction": direction,
                                 @"location" : location
                                 };
    
    NSUInteger u = [[dict objectForKey:@"user_ID"] intValue];
    
    
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
