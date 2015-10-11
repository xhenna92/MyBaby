//
//  CreateEventViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "CreateEventViewController.h"
#import "Event.h"

#import <CoreLocation/CoreLocation.h>

@interface CreateEventViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double eventLocationLat;
@property (nonatomic) double eventLocationLng;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // grab location
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    self.eventLocationLat = newLocation.coordinate.latitude;
    self.eventLocationLng = newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    NSLog( @"location lat %f, location lat %f",newLocation.coordinate.latitude , newLocation.coordinate.longitude);

    
}
- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    Event *event = [[Event alloc]init];
    event.eventName = self.eventNameTextField.text;
    event.eventDescription = self.eventDescriptionTextField.text;
    event.eventCoordinateLat = self.eventLocationLat;
    event.eventCoordinatelng = self.eventLocationLng;
//    [self.locationManager stopUpdatingLocation];
    
    [event saveInBackground];

}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
