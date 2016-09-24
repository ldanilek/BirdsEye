//
//  LocationModule.h
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModule : NSObject

- (double)currentLatitude;
- (double)currentLongitude;

// in meters per second
- (double)currentSpeed;
// in degrees relative to true-north
- (double)currentDirection;

@end
