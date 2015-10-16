//
//  ChildDetailProfileInfoTableViewCell.h
//  My Baby
//
//  Created by Jason Wang on 10/15/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildDetailProfileInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *brithdayWeightHeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *lullabySongLabel;

@end
