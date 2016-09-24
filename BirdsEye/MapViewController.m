//
//  MapViewController.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "MapViewController.h"
#import <MapBox/Mapbox.h>

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
    self.x = self.x+.01f;
    self.y = self.y+.01f;
    self.point.coordinate = CLLocationCoordinate2DMake(self.x, self.y);
}

@end
