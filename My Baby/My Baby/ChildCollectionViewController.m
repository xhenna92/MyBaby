//
//  ChildCollectionViewController.m
//  My Baby
//
//  Created by Jason Wang on 10/10/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "ChildCollectionViewController.h"
#import "ChildCollectionViewCell.h"
#import "ChildAddViewController.h"
#import "Child.h"
#import "ChildProfileDetailCollectionViewController.h"

@interface ChildCollectionViewController ()

@property (nonatomic) NSMutableArray *childrenProfileArray;

@end

@implementation ChildCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.childrenProfileArray = [[NSMutableArray alloc] init];
    
    [self setUpAndFetchParseQuery];
    
    
    

    

}


-(void)setUpAndFetchParseQuery{
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"children"];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"children"]);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Child"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
        if (!error) {
            [self.childrenProfileArray removeAllObjects];
            [self.childrenProfileArray addObject:@"+"];
            
            for (int i = 0; i < objects.count ; i++) {
                Child *childInfo = objects[i];
                [self.childrenProfileArray insertObject:childInfo atIndex:0];

                
                    NSArray *staticChildren = [[NSUserDefaults standardUserDefaults] objectForKey:@"children"];
                    NSMutableArray * mutableChildren = [[NSMutableArray alloc] initWithArray:staticChildren];
                    [mutableChildren addObject:childInfo.childName];
                    NSArray *finalArray = [[NSArray alloc] initWithArray:mutableChildren];
                    
                    [ [NSUserDefaults standardUserDefaults] setObject:finalArray forKey:@"children"];
            }
            [self.collectionView reloadData];
        }
        
    }];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childrenProfileArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChildCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChildProfileReusableCell" forIndexPath:indexPath];
    if (indexPath.row == self.childrenProfileArray.count - 1){
        
        cell.childNameLabel.text = @"";
        cell.childImageView.image = [UIImage imageNamed:@"addChildButton"];

        
    }
    else{
        Child *child = [self.childrenProfileArray objectAtIndex:indexPath.row];
        cell.childNameLabel.text = child.childName;
        PFFile *imageFile = child.childImage;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                                                     if (!error) {
                                                         cell.childImageView.image = [UIImage imageWithData:data];
                                                     }
                                                 }];

        
        cell.childImageView.layer.cornerRadius = 75.0;
        cell.childImageView.layer.masksToBounds = YES;
        
        
    
    }
    
    return cell;
    
    
}

#pragma mark - <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (indexPath.row == self.childrenProfileArray.count - 1) {
        ChildAddViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChildAddVCStoryBoardID"];
        [self presentViewController:vc animated:YES completion:nil];
        
    } else {
        ChildProfileDetailCollectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChildProfileDtailCollectionVCID"];
        vc.child = self.childrenProfileArray[indexPath.row];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

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
