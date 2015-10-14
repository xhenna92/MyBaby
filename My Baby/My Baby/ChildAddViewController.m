//
//  ChildAddViewController.m
//  My Baby
//
//  Created by Henna on 10/11/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ChildAddViewController.h"
#import "Child.h"

@interface ChildAddViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) NSMutableArray * feetOptions;
@property (nonatomic) NSMutableArray * inchesOptions;
@property (nonatomic) BOOL gender;
@property (strong, nonatomic) IBOutlet UIDatePicker *childDOBDatePicker;
@property (nonatomic) NSString *childDOBString;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (nonatomic) NSNumber *heightFt;
@property (nonatomic) NSNumber *heightIn;


@end

@implementation ChildAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feetOptions = [[NSMutableArray alloc] init];
    self.inchesOptions = [[NSMutableArray alloc] init];
    self.heightIn = 0;
    self.heightFt = 0;
    self.heightTextField.delegate = self;
    self.heightPickerView.hidden = true;
    self.childDOBDatePicker.datePickerMode = UIDatePickerModeDate;
    

    
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.heightPickerView.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnPressToGetValue)];
    [toolBar setItems:[NSArray arrayWithObject:btn]];
    [self.heightPickerView addSubview:toolBar];    
    
    
    self.heightPickerView.delegate = self;
    self.heightPickerView.dataSource=self;
    self.heightPickerView.showsSelectionIndicator = YES;
}

- (void) doneBtnPressToGetValue {
 self.heightPickerView.hidden = true;
}

#pragma mark - Height Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    // components are like columns. one column for feet and one for inches
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return [[self getUserDetailsHeightFeetOptions]count];
    } else {
        return [[self getUserDetailsHeightInchesOptions]count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [NSString stringWithFormat:@"%@ ft", [[self getUserDetailsHeightFeetOptions]objectAtIndex:row]];
    } else {
        return [NSString stringWithFormat:@"%@ in", [[self getUserDetailsHeightInchesOptions]objectAtIndex:row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0)
    {
        self.heightFt = self.feetOptions[row];
    }
    else{
        self.heightIn = self.inchesOptions[row];
    }
    

    
    
}

- (NSArray*)getUserDetailsHeightFeetOptions{
    
    for (int i = 3; i < 8; i++) {
        [self.feetOptions addObject:[NSNumber numberWithInt:i]];
    }
    return self.feetOptions;
}

- (NSArray*)getUserDetailsHeightInchesOptions{

    for (int i = 0; i < 12; i++) {
        [self.inchesOptions addObject:[NSNumber numberWithInt:i]];
    }
    return self.inchesOptions;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [self.view endEditing:YES];
    self.heightPickerView.hidden = false;
    return false;
    
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
