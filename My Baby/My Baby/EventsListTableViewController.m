//
//  EventsListTableViewController.m
//  My Baby
//
//  Created by Jason Wang on 10/11/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import "EventsListTableViewController.h"
#import <Parse/Parse.h>
#import "EventTableViewCell.h"
#import "Event.h"
#import "EventDetailViewController.h"


@interface EventsListTableViewController ()

@property (nonatomic) NSMutableArray *eventsArray;
@property (nonatomic) NSArray *months;

@end

@implementation EventsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"EventTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"eventCellIdentifier"];
    self.eventsArray = [[NSMutableArray alloc] init];
    self.months = [[NSArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    
    [self fetchParseQuery];
}

-(void)fetchParseQuery{

    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error) {
        if (!error) {
            
            for(Event *event in objects){
                [self.eventsArray addObject: event];
            }
            
        }
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCellIdentifier" forIndexPath:indexPath];
    
    Event *event = [self.eventsArray objectAtIndex:indexPath.row];
    cell.eventNameLabel.text =event.eventName;
    cell.eventDescriptionLabel.text =event.eventDescription;
    NSArray *arr = [event.eventDate componentsSeparatedByString:@"-"];
    NSInteger month = [arr[1] integerValue];
    month = month -1;
    cell.eventTimeLabel.text = arr[2];
    cell.eventMonthLabel.text = [self.months objectAtIndex:month];
    cell.eventDayLabel.text = arr[0];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventDetailViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"eventDetailView"];
    ivc.eventInfo = [self.eventsArray objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:ivc animated:YES];

}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView ​*)tableView canEditRowAtIndexPath:(NSIndexPath *​)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView ​*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *​)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView ​*)tableView moveRowAtIndexPath:(NSIndexPath *​)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView ​*)tableView canMoveRowAtIndexPath:(NSIndexPath *​)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end