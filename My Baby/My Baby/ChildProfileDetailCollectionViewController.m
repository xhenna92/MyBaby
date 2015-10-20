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

@interface ChildProfileDetailCollectionViewController ()

@property (nonatomic) NSDictionary *profileData;

@end

@implementation ChildProfileDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    
    NSString *childName = @"childName";
    NSArray *moment = @[@"Picture1", @"Picture2", @"Picture3", @"Picture4", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5", @"Picture5"];
    self.profileData = @{@"childName" : childName, @"moment" :moment };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

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
        cell1.profileImageView.image = self.profileData[@"childImage"];
        [cell1.layer setCornerRadius:75];
        cell1.backgroundColor = [UIColor blueColor];
        return cell1;
    }
    if (indexPath.section > 0) {
        ChildProfileMomentsCollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"MomentCellID" forIndexPath:indexPath];
        cell2.momentImageView.image = self.profileData[@"moment"][indexPath.row];
        cell2.backgroundColor = [UIColor greenColor];
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
    headerView.headerLabel.backgroundColor = [UIColor redColor];
    
    if (indexPath.section > 0) {
        NSLog(@"second section");
        return headerView;
    } else {
        NSLog(@"first section");
        [headerView setHidden:YES];
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
