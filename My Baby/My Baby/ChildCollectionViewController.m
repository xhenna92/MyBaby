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
#import "AddCollectionViewCell.h"

@interface ChildCollectionViewController ()

@property (nonatomic) NSMutableArray *childrenProfileArray;

@end

@implementation ChildCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.childrenProfileArray = [[NSMutableArray alloc]init];
    
    [self.childrenProfileArray addObject:@"+"];
//    [self.childrenProfileArray insertObject:@"Child 1" atIndex:self.childrenProfileArray.count-1];
//    [self.childrenProfileArray insertObject:@"Child 2" atIndex:self.childrenProfileArray.count-1];
//    [self.childrenProfileArray insertObject:@"Child 3" atIndex:self.childrenProfileArray.count-1];
//    [self.childrenProfileArray insertObject:@"Adpoted Child" atIndex:self.childrenProfileArray.count-1];
//    [self.childrenProfileArray insertObject:@"Street Child" atIndex:self.childrenProfileArray.count-1];
//    [self.childrenProfileArray insertObject:@"Random Child" atIndex:self.childrenProfileArray.count-1];
    
    
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
    
    if (self.childrenProfileArray.count < 2 ) {
        AddCollectionViewCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddProfileReusableCell" forIndexPath:indexPath];
        addCell.addLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"addProfile"]];
        [addCell.addLabel.layer setCornerRadius:75.0];
        [addCell.addLabel.layer setBorderColor:[UIColor greenColor].CGColor];
        return addCell;
    } else {
        ChildCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChildProfileReusableCell" forIndexPath:indexPath];
        
        cell.childNameLabel.text = [self.childrenProfileArray objectAtIndex:indexPath.row];
        cell.childImageView.image = [UIImage imageNamed:@"testbaby"];
        
        
        [cell.childImageView.layer setCornerRadius:75.0];
        [cell.childImageView.layer setBorderColor:[UIColor blackColor].CGColor];
        return cell;
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
