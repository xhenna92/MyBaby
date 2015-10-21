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
#import <NDCollapsiveDatePicker/NDCollapsiveDateView.h>
#import "RMPickerViewController.h"


@interface CreateEventViewController () <NDCollapsiveDateViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *pickChildButton;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double eventLocationLat;
@property (nonatomic) double eventLocationLng;
@property (nonatomic) NSString *eventDate;
@property (nonatomic) NDCollapsiveDateView *collapsiveDateView;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (nonatomic) NSMutableArray *childNames;
@property (nonatomic) NSString *chosenChild;
@end


@implementation CreateEventViewController
- (IBAction)pickChildButtonTapped:(UIButton *)sender {
    
    RMActionControllerStyle style = RMActionControllerStyleWhite;

    //implement which child it's under
    //Create select action
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        NSMutableArray *selectedRows = [NSMutableArray array];
        
        for(NSInteger i=0 ; i<[picker numberOfComponents] ; i++) {
            [selectedRows addObject:@([picker selectedRowInComponent:i])];
        }
        
        self.chosenChild = [self.childNames objectAtIndex:[[selectedRows objectAtIndex:0] integerValue]];
        [self.pickChildButton setTitle:self.chosenChild forState:UIControlStateNormal];
    }];
    
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {}];
    
    RMPickerViewController *pickerController = [RMPickerViewController actionControllerWithStyle:style];
    pickerController.title = @"Test";
    pickerController.message = @"This is a test message.\nPlease choose a row and press 'Select' or 'Cancel'.";
    pickerController.picker.dataSource = self;
    pickerController.picker.delegate = self;
    
    [pickerController addAction:selectAction];
    [pickerController addAction:cancelAction];
    //You can enable or disable blur, bouncing and motion effects
    pickerController.disableBouncingEffects = YES;
    pickerController.disableMotionEffects = YES;
    pickerController.disableBlurEffects = YES;
    
    
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - RMPickerViewController Delegates
- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    

}

- (void)pickerViewControllerDidCancel:(RMPickerViewController *)vc {
    NSLog(@"Selection was canceled");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.childNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.childNames objectAtIndex:row];
}

# pragma mark - date Picker delegates

-(void)datePickerViewDidCollapse:(NDCollapsiveDatePickerView *)datePickerView{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    self.eventDate = [dateFormatter stringFromDate:datePickerView.date];
    
}

- (IBAction)choosePictureButtonTapped:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.eventImage.image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.childNames = [[NSUserDefaults standardUserDefaults] objectForKey:@"children"];
    self.eventImage.image = [UIImage imageNamed:@"testbaby"];
    if(self.childNames.count < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please Add Children"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];

        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        self.pickChildButton.layer.cornerRadius = 10;
        self.pickChildButton.clipsToBounds = YES;
        self.chosenChild = [self.childNames objectAtIndex:0];
        [self.pickChildButton setTitle:self.chosenChild forState:UIControlStateNormal];

        //calendar init
        CGRect frame = CGRectMake(self.view.frame.size.width / 2 - 150, self.view.frame.size.height / 2 - 100, 300, 60);
        
        self.collapsiveDateView = [[NDCollapsiveDateView alloc] initWithFrame:frame title:@"Date" image:[UIImage imageNamed:@"add_event_nav_icon"] hiddenHeight:50 andShownHeight:200.f];
        self.collapsiveDateView.delegate = self;
        [self.view addSubview:self.collapsiveDateView];
        
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
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    self.eventLocationLat = newLocation.coordinate.latitude;
    self.eventLocationLng = newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    NSLog( @"location lat %f, location lat %f",newLocation.coordinate.latitude , newLocation.coordinate.longitude);
    
    
}
- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    Event *event = [[Event alloc]init];
    
    event.eventName = @"";
    event.eventDescription = @"";
    event.eventCoordinateLat = 0;
    event.eventCoordinatelng = 0;
    event.eventDate = @"";
    event.childID = @"";
    
    event.eventName = self.eventNameTextField.text;
    event.eventDescription = self.eventDescriptionTextField.text;
    event.eventCoordinateLat = self.eventLocationLat;
    event.eventCoordinatelng = self.eventLocationLng;
    event.eventDate = self.eventDate;
    event.childID = self.chosenChild;
    
    NSData* data = UIImageJPEGRepresentation(self.eventImage.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [event setObject:imageFile forKey:@"eventImage"];
            [event saveInBackground];
        }
        else{
            NSLog(@" did not upload file ");
        }
    }];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    NSLog(@"dismissing");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
