//
//  EventDetailViewController.m
//  My Baby
//
//  Created by Henna on 10/17/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventNameLabel.text = self.eventInfo.eventName;
    self.eventDescriptionLabel.text = self.eventInfo.eventDescription;
    PFFile *imageFile = self.eventInfo.eventImage;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.eventImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    self.descriptionView.layer.cornerRadius = 20;
    
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
