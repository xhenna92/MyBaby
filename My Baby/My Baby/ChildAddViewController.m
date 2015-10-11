//
//  ChildAddViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ChildAddViewController.h"
#import "Child.h"

@interface ChildAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) BOOL gender;
@property (strong, nonatomic) IBOutlet UIDatePicker *childDOBDatePicker;
@property (nonatomic) NSString *childDOBString;

@end

@implementation ChildAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.childDOBDatePicker.datePickerMode = UIDatePickerModeDate;
}


#pragma mark - IBAction Interaction

- (IBAction)childDOBPicker:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *formatedDate = [dateFormatter stringFromDate: self.childDOBDatePicker.date];
    self.childDOBString = formatedDate;
}

- (IBAction)genderSegmentedControl:(UISegmentedControl *)sender {
    
    switch(sender.selectedSegmentIndex){
            case 0:
                self.gender = NO;
                break;
            case 1:
                self.gender = YES;
                break;
    }
    
}

- (IBAction)saveChild:(UIBarButtonItem *)sender {
    //send data to parse
    Child *child = [[Child alloc] init];
    child.childName = self.nameTextField.text;
    child.childGender = self.gender;
    child.childDOB = self.childDOBString;
    [child saveInBackground];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
