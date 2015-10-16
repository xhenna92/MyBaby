//
//  ChildDetailProfileMomentsTableViewCell.m
//  My Baby
//
//  Created by Jason Wang on 10/15/15.
//  Copyright © 2015 Henna. All rights reserved.
//

#import "ChildDetailProfileMomentsTableViewCell.h"

@implementation ChildDetailProfileMomentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *momentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"momentCellID" forIndexPath:indexPath];
//    momentCell.backgroundView
    return momentCell;
}
@end
