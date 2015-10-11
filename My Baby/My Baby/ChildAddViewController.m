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

@end

@implementation ChildAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
