//
//  EventListViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "EventListViewController.h"

@interface EventListViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerCalendarView;
@property (weak, nonatomic) IBOutlet UIView *containerListView;


@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerCalendarView.hidden = NO;
    self.containerListView.hidden = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)calendarListSegmentedController:(UISegmentedControl *)sender {

    switch(sender.selectedSegmentIndex){
        case 0:
            self.containerCalendarView.hidden = NO;
            self.containerListView.hidden = YES;
            break;
        case 1:
            
            self.containerCalendarView.hidden = YES;
            self.containerListView.hidden = NO;

            break;
    }
    
    
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