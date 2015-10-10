//
//  ChildCollectionViewController.m
//  My Baby
//
//  Created by Jason Wang on 10/10/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ChildCollectionViewController.h"
#import "ChildCollectionViewCell.h"

@interface ChildCollectionViewController ()

@property (nonatomic) NSMutableArray *childrenProfileArray;

@end

@implementation ChildCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.childrenProfileArray = [[NSMutableArray alloc]init];
    [self.childrenProfileArray addObject:@"Child 1"];
    [self.childrenProfileArray addObject:@"Child 2"];
    [self.childrenProfileArray addObject:@"Child 3"];
    [self.childrenProfileArray addObject:@"Adpoted Child"];
    [self.childrenProfileArray addObject:@"Street Child"];
    [self.childrenProfileArray addObject:@"Random Child"];
    [self.childrenProfileArray addObject:@"+"];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

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
    [cell.childImageView.layer setCornerRadius:75.0];
    [cell.childImageView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    return cell;
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
