//
//  ChildProfileBioCollectionViewCell.h
//  My Baby
//
//  Created by Jason Wang on 10/20/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildProfileBioCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthdayWeightHeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *lullabySongLabel;

@end
