//
//  RequestModule.h
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModule : NSObject

// designated initializer
+ (RequestModule *)sharedModule;

// connects to the server?, sends a JSON of info about the user
- (void) connectBackEnd: (NSInteger) userID andGroupID: (NSInteger) group_id;

@end
