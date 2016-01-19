//
//  MapViewController.h
//  Networking-Map
//
//  Created by John Andrews on 1/18/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Contact.h"

@interface MapViewController : ViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Contact *contact;
@end
