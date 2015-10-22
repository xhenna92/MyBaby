//
//  placeDetailViewController.m
//  My Baby
//
//  Created by Henna on 10/22/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "placeDetailViewController.h"
#import "APIManager.h"


@interface placeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *stations;

@end

@implementation placeDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.name.text = self.fourSquareObject.name;
    self.address.text = self.fourSquareObject.address;
    
    [self makeGoogleAPIRequestWithSearchTermWithcallbackBlock:^{
        [self.tableView reloadData];
    }];
    
    //    NSURL *imgURL = [NSURL URLWithString:result.imgURL];
    //    NSData *imageData = [NSData dataWithContentsOfURL:imgURL];
    //    UIImage *imageToDisplay = [UIImage imageWithData:imageData];
    
    
    // Do any additional setup after loading the view.
}

- (void) makeGoogleAPIRequestWithSearchTermWithcallbackBlock:(void(^)())block{
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@&rankby=distance&types=subway_station|transit_station&key=AIzaSyAWnqNcCoTk_j7oZabHJkVZW0ULVFg5uZ0", self.fourSquareObject.latlng];
    
    NSLog(@"%@", urlString);
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL   URLWithString:encodedString];
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.stations = [[NSMutableArray alloc]init];
            
            NSArray *results = [json objectForKey:@"results"];
            //AIzaSyAWnqNcCoTk_j7oZabHJkVZW0ULVFg5uZ0
            
            for (NSDictionary *result in results) {
                
                [self.stations addObject:[result objectForKey:@"name"]];
            }
            block();
        }
        
    }];
    
}

# pragma mark -tableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.stations.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubwayCellIdentifier" forIndexPath:indexPath];
    NSString * station = [self.stations objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = station;
    //    cell.detailTextLabel.text = result.author;
    //    cell.imageView.image = imageToDisplay;
    return cell;
}
@end
