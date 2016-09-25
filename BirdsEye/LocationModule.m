//
//  LocationModule.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "LocationModule.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationModule () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *manager;
@property (nonatomic) CLLocation *currentLocation;

@end

@implementation LocationModule

+ (LocationModule *)sharedModule {
    static LocationModule *module = nil;
    if (!module) {
        module = [[self alloc] init];
    }
    return module;
}

- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _manager.distanceFilter = kCLDistanceFilterNone; // get all updates
        _manager.delegate = self;
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

- (double)latitude {
    return self.currentLocation.coordinate.latitude;
}

- (double)longitude {
    return self.currentLocation.coordinate.longitude;
}

- (double)uncertaintyRadius {
    return self.currentLocation.horizontalAccuracy;
}

- (double)speed {
    return self.currentLocation.speed;
}

- (double)direction {
    return self.currentLocation.course;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentLocation = locations.lastObject;
}

@end
