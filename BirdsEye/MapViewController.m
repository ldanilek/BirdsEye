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

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(45.52258, -122.6732); //change this to read from location module eventually
    point.title = @"Voodoo Doughnut";
    point.subtitle = @"22 SW 3rd Avenue Portland Oregon, U.S.A.";
    
    [self.mapView addAnnotation:point];
    
    
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
