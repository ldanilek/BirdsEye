//
//  LocationModule.h
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModule : NSObject

// asks the user if location information can be used, if not already authorized
- (void)requestLocationAccess;

// since using the GPS is battery-intensive, only use it when necessary
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

// these are the main methods to get data
- (double)currentLatitude;
- (double)currentLongitude;

// in meters per second
- (double)currentSpeed;
// in degrees relative to true-north
- (double)currentDirection;

@end
