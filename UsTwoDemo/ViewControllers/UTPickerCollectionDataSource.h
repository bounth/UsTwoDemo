//
//  UTPickerCollectionDataSource.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import UIKit;

typedef UICollectionViewCell * (^UTPickerCustomizeCellBlock)(UICollectionViewCell *cell, NSInteger index);
typedef void (^UTPickerUpdatedIndex)(NSInteger index);

@interface UTPickerCollectionDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

- (void)refreshWithNumberOfItems:(NSInteger)nbOfItem
             collectionViewWidth:(CGFloat)width
                   customizeCell:(UTPickerCustomizeCellBlock)cellBlock;

- (void)pageIndexDidUpdate:(UTPickerUpdatedIndex)indexBlock;
@end
