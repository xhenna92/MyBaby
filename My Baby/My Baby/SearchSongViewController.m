//
//  SearchSongViewController.m
//  My Baby
//
//  Created by Jason Wang on 10/20/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import "SearchSongViewController.h"
#import "APIManager.h"
#import "Place.h"
#import <CoreLocation/CoreLocation.h>



@interface SearchSongViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *searchSongTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *places;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double eventLocationLat;
@property (nonatomic) double eventLocationLng;


@end



@implementation SearchSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.searchSongTextField setDelegate:self];
    // grab location
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];

    NSString * query = @"places";
    NSString *location = [NSString stringWithFormat:@"%f,%f", self.eventLocationLat, self.eventLocationLng];
    NSLog(@"%@", location);
    [self makeFSAPIRequestWithSearchTerm:query andLocation:location callbackBlock:^{
        [self.tableView reloadData];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    self.eventLocationLat = newLocation.coordinate.latitude;
    self.eventLocationLng = newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    
}

- (void) makeFSAPIRequestWithSearchTerm:(NSString*) searchTerm andLocation:(NSString*) location callbackBlock:(void(^)())block{
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&query=%@&client_id=V4EZD2DVUA5S4EW4UWUFJQRCRO3L0QEBRZ2MNOA2IAVF2VXY&client_secret=J1KFSATHO1PDRRLDSQCEBSZ0ULLBVK20YC1WYIN3T53LXXPX&v=20150924", location, searchTerm];
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL   URLWithString:encodedString];
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.places = [[NSMutableArray alloc]init];
            
            NSArray *results = [[json objectForKey:@"response"] objectForKey:@"venues"];
            
            
            for (NSDictionary *result in results) {
                Place *obj = [[Place alloc]init];
                obj.name = [result objectForKey:@"name"];
                NSString *address = [[result objectForKey:@"location"] objectForKey:@"address"];
                NSString *city = [[result objectForKey:@"location"] objectForKey:@"city"];
                NSString *state = [[result objectForKey:@"location"] objectForKey:@"state"];
                NSString *postalCode = [[result objectForKey:@"location"] objectForKey:@"postalCode"];
                
                obj.address = [NSString stringWithFormat:@"%@ %@, %@ %@", address, city, state, postalCode];
                
                [self.places addObject:obj];
            }
            block();
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -tableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.places.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCellIdentifier" forIndexPath:indexPath];
    Place *place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.address;
    //cell.imageView.image = imageToDisplay;
    
    return cell;
}

# pragma mark - text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    NSString * query = self.searchSongTextField.text;
    NSString *location = [NSString stringWithFormat:@"%f,%f", self.eventLocationLat, self.eventLocationLng];
    NSLog(@"%f, %f", self.eventLocationLat, self.eventLocationLng);
    [self makeFSAPIRequestWithSearchTerm:query andLocation:location callbackBlock:^{
         [self.tableView reloadData];
    }];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Place * place = [self.places objectAtIndex:indexPath.row];
    NSLog(@"%@", place.name);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
