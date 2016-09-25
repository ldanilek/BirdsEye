//
//  MapViewController.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "MapViewController.h"
#import <MapBox/Mapbox.h>
#import "CustomAnnotationView.h"
#import "RequestModule.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MGLMapView *mapView;

@property (weak) NSTimer *repeatingTimer;


@property (strong, nonatomic) NSMutableDictionary *userDict;
@property (strong, nonatomic) NSMutableDictionary *teamMap;


//important info storage, maybe shouldnt go here?
@property int groupId;
@property int teamId;
@property int userId;

@property (strong, nonatomic) RequestModule *request;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UILabel *speedLabel = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    // Do any additional setup after loading the view, typically from a nib.
    //setup the timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(updateCoordinates:)
                                                    userInfo:nil repeats:YES];
    self.repeatingTimer = timer;
    
    
    //setup userDict
    self.userDict = [[NSMutableDictionary alloc] init];
    self.teamMap = [[NSMutableDictionary alloc] init];
    
    self.request = [RequestModule sharedModule];
//    //testing points
//    // Specify coordinates for our annotations.
//    CLLocationCoordinate2D coordinates[] = {
//        CLLocationCoordinate2DMake(0, 33),
//        CLLocationCoordinate2DMake(0, 66),
//        CLLocationCoordinate2DMake(0, 99),
//    };
//    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
//    
//    // Fill an array with point annotations and add it to the map.
//    NSMutableArray *pointAnnotations = [NSMutableArray arrayWithCapacity:numberOfCoordinates];
//    for (NSUInteger i = 0; i < numberOfCoordinates; i++) {
//        CLLocationCoordinate2D coordinate = coordinates[i];
//        MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
//        point.coordinate = coordinate;
//        point.title = [NSString stringWithFormat:@"%.f, %.f", coordinate.latitude, coordinate.longitude];
//        [pointAnnotations addObject:point];
//    }
//    
//    [self.mapView addAnnotations:pointAnnotations];
    
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCoordinates:(NSTimer*)timer {
    //call shanelle's update function here, the rest of this probably goes in a callback
    [self.request pingInfo:self.userId andGroupID:self.groupId andReturningData:^(NSDictionary *newDict) {
        if (newDict) {
            [self updateUserDict:newDict];
        }
    }];
    //temp
//    NSDictionary *newDict = [[NSDictionary alloc] init];
//    
//    [self updateUserDict:newDict];
    
    //sometimes were probably going to want to make annotations visible or invisible, we can do that here
    
}

- (MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id <MGLAnnotation>)annotation {
    // This example is only concerned with point annotations.
    if (![annotation isKindOfClass:[MGLPointAnnotation class]]) {
        return nil;
    }
    
    // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%f", annotation.coordinate.longitude];
    
    // For better performance, always try to reuse existing annotations.
    CustomAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    
    // If there’s no reusable annotation view available, initialize a new one.
    if (!annotationView) {
        annotationView = [[CustomAnnotationView alloc] initWithReuseIdentifier:reuseIdentifier];
        annotationView.frame = CGRectMake(0, 0, 12, 12);
        
        // Set the annotation view’s background color to a value determined by its longitude.
        CGFloat hue = (CGFloat)1;
        annotationView.backgroundColor = [UIColor colorWithHue:hue saturation:0.5 brightness:1 alpha:1];
    }
    
    return annotationView;
}

-(void)updateUserDict:(NSDictionary*) newDict {
    NSArray *array = newDict[@"locations"];
    for (NSDictionary *newData in array) {
        //if user exists in the existing data, update them
        MGLPointAnnotation *point;
        if ((point = _userDict[newData[@"id"]]) != NULL) {
            point.coordinate = CLLocationCoordinate2DMake([newData[@"latitude"] doubleValue], [newData[@"longitude"] doubleValue]);
        } else {
            //create them
            point = [[MGLPointAnnotation alloc] init];
            NSLog(@"adding user %@", newData[@"id"]);
            point.coordinate = CLLocationCoordinate2DMake([newData[@"latitude"] doubleValue], [newData[@"longitude"] doubleValue]);
            [self.mapView addAnnotation:point];
            [_userDict setObject:point forKey:newData[@"id"]];
            [_teamMap setObject:newData[@"team"] forKey:newData[@"id"]];
        }
    }
    
    //remove users that are no longer sending location data
    for(id key in _userDict) {
        MGLPointAnnotation *point = [_userDict objectForKey:key];
        BOOL found = false;
        for (NSDictionary *newData in array) {
            if (newData[@"id"] == key) {
                found = true;
            }
        }
        if (!found) {
            NSLog(@"removing user %@", key);
            [self.mapView removeAnnotation:point];
            [_userDict removeObjectForKey:key];
        }
    }
}

@end
