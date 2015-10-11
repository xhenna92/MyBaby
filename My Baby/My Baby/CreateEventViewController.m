//
//  CreateEventViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "CreateEventViewController.h"
#import "Event.h"

@interface CreateEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    Event *event = [[Event alloc]init];
    event.eventName = self.eventNameTextField.text;
    event.eventDescription = self.eventDescriptionTextField.text;
    [event saveInBackground];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
