//
//  LocationModule.h
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModule : NSObject

// designated initializer is |init|.

// asks the user if location information can be used, if not already authorized
- (void)requestLocationAccess;

// since using the GPS is battery-intensive, only use it when necessary
// initially the module is not updating location
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

// these are the main methods to get data
- (double)latitude;
- (double)longitude;
// in meters
- (double)uncertaintyRadius;

// in meters per second
- (double)speed;
// in degrees relative to true-north
- (double)direction;

@end
