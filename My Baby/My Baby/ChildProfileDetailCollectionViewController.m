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

@interface ChildProfileDetailCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) NSDictionary *profileData;

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

    self.profileData = [[NSMutableDictionary alloc] init];
    
    NSString *childName = self.child.childName;
    
    self.momentsArray = [[NSMutableArray alloc]init];
    [self.momentsArray addObject:[UIImage imageNamed:@"addChildButton"]];
    
    self.profileData = @{@"childName" : childName, @"moment" :self.momentsArray };
    
    
}



#pragma mark <UICollectionViewDataSource>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == [self.profileData[@"moment"] count]-1) {
        UIAlertView *photoTypeAlert = [[UIAlertView alloc] initWithTitle:@"Camera or Library Photo" message:@"Please Select One" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Photo Library", nil];
        [photoTypeAlert show];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"No Camera is Detected" message:@"Please run it on your iPhone device for it to function" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [noCameraAlert show];
        } else {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    } else if (buttonIndex == 2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.momentsArray setObject:image atIndexedSubscript:0];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.profileData allKeys].count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        return [self.profileData[@"moment"] count];
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

        //cell1.profileImageView.image = self.profileData[@"childImage"];
        
        [cell1.layer setCornerRadius:75];
        cell1.backgroundColor = [UIColor blueColor];
        return cell1;
    }
    if (indexPath.section > 0) {
        ChildProfileMomentsCollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"MomentCellID" forIndexPath:indexPath];
        cell2.momentImageView.image = self.profileData[@"moment"][indexPath.row];
        cell2.backgroundColor = [UIColor whiteColor];
        cell2.momentImageView.image = self.momentsArray[indexPath.row];
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
        return UIEdgeInsetsMake(50, 10, 50, 10);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(150, 150);
    } else {
        return CGSizeMake(100, 100);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 8;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ProfilePicHeaderCollectionReusableView *headerView = [[ProfilePicHeaderCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 20)];
    
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
    headerView.headerLabel.text = @"Moments";
    headerView.headerLabel.backgroundColor = [UIColor colorWithRed:0.992 green:0.376 blue:0.502 alpha:1];
    
    if (indexPath.section > 0) {
        [headerView.doneButton setHidden:YES];
        return headerView;
    } else {
        [headerView.headerLabel setHidden:YES];
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
