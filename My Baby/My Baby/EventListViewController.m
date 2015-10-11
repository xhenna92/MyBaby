//
//  EventListViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "EventListViewController.h"

@interface EventListViewController ()

@property (weak, nonatomic) IBOutlet UIView *calendarSectionView;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)calendarListSegmentedController:(UISegmentedControl *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
