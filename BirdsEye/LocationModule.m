//
//  LocationModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "LocationModule.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationModule ()

@property (nonatomic) CLLocationManager *manager;

@end

@implementation LocationModule

- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _manager;
}

- (void)startUpdatingLocation {
    [self.manager startUpdatingLocation];
}

- (void)stopUpdatingLocation {
    [self.manager stopUpdatingLocation];
}

- (void)requestLocationAccess {
    [self.manager requestWhenInUseAuthorization];
}

- (double)currentLatitude {
    return 0;
}

- (double)currentLongitude {
    return 0;
}

- (double)currentSpeed {
    return 0;
}

- (double)currentDirection {
    return 0;
}

@end
