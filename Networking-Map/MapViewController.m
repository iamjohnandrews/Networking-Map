//
//  MapViewController.m
//  Networking-Map
//
//  Created by John Andrews on 1/18/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "MapViewController.h"

static NSString *citrixName = @"Citrix";

@interface MapViewController () <MKMapViewDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    // approximate location of Citrix
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.836535;
    zoomLocation.longitude= -78.687916;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1000, 1000);
    [self.mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = zoomLocation;
    myAnnotation.title = self.contact.companyName ? self.contact.companyName : self.contact.name;
    myAnnotation.subtitle = self.contact.addresses.lastObject;
    
    [self.mapView addAnnotation:myAnnotation];
}

#pragma MapKit Delegate Method

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:citrixName];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:citrixName];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
    }
    
    return annotationView;
}

@end
