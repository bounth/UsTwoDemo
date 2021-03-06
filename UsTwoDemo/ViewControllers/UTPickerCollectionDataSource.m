//
//  UTPickerCollectionDataSource.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTPickerCollectionDataSource.h"

#define kCellWidth 150

@interface UTPickerCollectionDataSource ()

@property (nonatomic, copy) UTPickerCustomizeCellBlock customizeCellBlock;
@property (nonatomic, copy) UTPickerUpdatedIndex updatedIndexBlock;
@property (nonatomic, assign) CGFloat linespace;
@property (nonatomic, assign) NSInteger numberOfItem;

@end

@implementation UTPickerCollectionDataSource

//
//  Replace the UICollectionView required delegate by block
//------------------------------------------------------------------------------
- (void)refreshWithNumberOfItems:(NSInteger)nbOfItem
             collectionViewWidth:(CGFloat)width
                   customizeCell:(UTPickerCustomizeCellBlock)cellBlock {
    self.numberOfItem = nbOfItem;
    self.linespace = (width - kCellWidth) / 4;
    self.customizeCellBlock = cellBlock;
}

//
//  Return the current index page after a scroll
//------------------------------------------------------------------------------
- (void)pageIndexDidUpdate:(UTPickerUpdatedIndex)indexBlock {
    self.updatedIndexBlock = indexBlock;
}

#pragma mark - CollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberOfItem;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                           forIndexPath:indexPath];
    if (self.customizeCellBlock)
        cell = self.customizeCellBlock(cell, indexPath.row);
    
    return cell;
}

#pragma mark - CollectionView Delegate

//
//  Add space between each cell
//------------------------------------------------------------------------------
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.linespace / 4;
}

//
//  Add margin on the left and right of the UICollectionView
//------------------------------------------------------------------------------
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0, self.linespace * 2, 0, self.linespace * 2);
}

//
//  Add a paging style scroll
//  Center the picker to the next or previous scrolled cell
//------------------------------------------------------------------------------
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float pageWidth = kCellWidth + self.linespace / 4; // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (self.updatedIndexBlock)
        self.updatedIndexBlock(index);
}

@end
