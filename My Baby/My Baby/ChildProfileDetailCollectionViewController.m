//
//  ChildProfileDetailCollectionViewController.m
//  My Baby
//
//  Created by Jason Wang on 10/20/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import "ChildProfileDetailCollectionViewController.h"
#import "ChildProfileBioCollectionViewCell.h"
#import "ChildProfileMomentsCollectionViewCell.h"
#import "ProfilePicHeaderCollectionReusableView.h"
#import <Parse/Parse.h>
#import "Event.h"

@interface ChildProfileDetailCollectionViewController () <UINavigationControllerDelegate>

@property (nonatomic) NSString *childName;

@property (nonatomic) NSMutableArray *momentsArray;



@end

@implementation ChildProfileDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (IBAction)doneButtonTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
    [[self navigationController] setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.momentsArray = [[NSMutableArray alloc]init];
    
    self.childName = self.child.childName;
    
    [self fetchParseQuery];
    
    
}



#pragma mark <UICollectionViewDataSource>

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

-(void)fetchParseQuery{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error) {
        if (!error) {
            
            for(Event *event in objects){
                NSLog(@"%@", event.childID);
                NSLog(@"%@", self.childName);
                if([event.childID isEqualToString: self.childName]){
                    [self.momentsArray addObject: event];
                }
            }
            
            NSLog(@"%lu", (unsigned long)self.momentsArray.count );
        }
        [self.collectionView reloadData];
    }];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        
        return self.momentsArray.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ChildProfileBioCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCellID" forIndexPath:indexPath];
        PFFile *imageFile = self.child.childImage;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell1.profileImageView.image = [UIImage imageWithData:data];
                
            }
        }];
        
        [cell1.layer setCornerRadius:75];
        cell1.backgroundColor = [UIColor blueColor];
        return cell1;
    }
    if (indexPath.section > 0) {
        
        ChildProfileMomentsCollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"MomentCellID" forIndexPath:indexPath];
        
        Event *event = [self.momentsArray objectAtIndex:indexPath.row];
        cell2.momentName.text = event.eventName;
        PFFile *imageFile = event.eventImage;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell2.momentImageView.image = [UIImage imageWithData:data];
            }
        }];


        [cell2.layer setCornerRadius:15];
        return cell2;
    } else {
        return nil;
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {
        return UIEdgeInsetsMake(60, 150, 50, 150);
    } else {
        return UIEdgeInsetsMake(50, 10, 0, 10);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(150, 150);
    } else {
        return CGSizeMake(150, 150);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 8;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ProfilePicHeaderCollectionReusableView *headerView = [[ProfilePicHeaderCollectionReusableView alloc]init];
    if (kind == UICollectionElementKindSectionHeader) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
        headerView.headerLabel.text = @"Moments";
        headerView.headerLabel.backgroundColor = [UIColor colorWithRed:0.992 green:0.376 blue:0.502 alpha:1];
    }
    
        if (indexPath.section > 0) {
            [headerView.doneButton setHidden:YES];
            [headerView.headerLabel setHidden:NO];
            return headerView;
        } else {
            [headerView.headerLabel setHidden:YES];
            [headerView.doneButton setHidden:NO];
            return headerView;
        }

}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
