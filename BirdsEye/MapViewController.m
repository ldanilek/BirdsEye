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

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MGLMapView *mapView;

@property (weak) NSTimer *repeatingTimer;


@property (strong, nonatomic) NSMutableDictionary *userDict;
@property MGLPointAnnotation *point;
@property float x;
@property float y;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set up voodoo donut store
    self.point = [[MGLPointAnnotation alloc] init];
    self.point.coordinate = CLLocationCoordinate2DMake(45.52258, -122.6732); //change this to read from location module eventually
    self.point.title = @"Voodoo Doughnut";
    self.point.subtitle = @"22 SW 3rd Avenue Portland Oregon, U.S.A.";
    
    //temp: setup x, y
    self.x = 45.52258f;
    self.y = -122.6732f;
    
    //setup the timer
    [self.mapView addAnnotation:self.point];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(updateCoordinates:)
                                                    userInfo:nil repeats:YES];
    self.repeatingTimer = timer;
    
    
    //setup userDict
    self.userDict = [[NSMutableDictionary alloc] init];
    
    //testing points
    // Specify coordinates for our annotations.
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 33),
        CLLocationCoordinate2DMake(0, 66),
        CLLocationCoordinate2DMake(0, 99),
    };
    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    // Fill an array with point annotations and add it to the map.
    NSMutableArray *pointAnnotations = [NSMutableArray arrayWithCapacity:numberOfCoordinates];
    for (NSUInteger i = 0; i < numberOfCoordinates; i++) {
        CLLocationCoordinate2D coordinate = coordinates[i];
        MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
        point.coordinate = coordinate;
        point.title = [NSString stringWithFormat:@"%.f, %.f", coordinate.latitude, coordinate.longitude];
        [pointAnnotations addObject:point];
    }
    
    [self.mapView addAnnotations:pointAnnotations];
    
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCoordinates:(NSTimer*)timer {
    //NSLog(@"asdf");
    self.x = self.x+.0001f;
    self.y = self.y+.0001f;
    self.point.coordinate = CLLocationCoordinate2DMake(self.x, self.y);
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

@end
