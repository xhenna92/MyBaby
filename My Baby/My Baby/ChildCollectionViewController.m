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

@interface ChildCollectionViewController ()

@property (nonatomic) NSMutableArray *childrenProfileArray;

@end

@implementation ChildCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.childrenProfileArray = [[NSMutableArray alloc]init];

    [self.childrenProfileArray addObject:@"+"];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self fetchParseQuery];

}


-(void)fetchParseQuery{
    PFQuery *query = [PFQuery queryWithClassName:@"Child"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
        if (!error) {
            for (int i = 0; i < objects.count ; i++) {
                NSMutableDictionary *childInfo = objects[i];
                NSString *childName = childInfo[@"childName"];
                [self.childrenProfileArray insertObject:childName atIndex:0];
            }
        }
        [self.collectionView reloadData];
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
        
        cell.childNameLabel.text = [self.childrenProfileArray objectAtIndex:indexPath.row];
        cell.childImageView.image = [UIImage imageNamed:@"testbaby"];
        cell.childImageView.layer.cornerRadius = 75.0;
        cell.childImageView.layer.masksToBounds = YES;

        return cell;
    
}

#pragma mark - <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.childrenProfileArray.count - 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChildAddViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChildAddVCStoryBoardID"];
        [self.navigationController pushViewController:vc animated:YES];
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
