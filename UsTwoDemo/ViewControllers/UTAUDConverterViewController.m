//
//  UTAUDConverterViewController.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTAUDConverterViewController.h"
#import "UTPickerCollectionDataSource.h"

#import "UTConverter.h"

@interface UTAUDConverterViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *fieldAUD;
@property (nonatomic, weak) IBOutlet UILabel *labelConverted;
@property (nonatomic, weak) IBOutlet UIButton *buttonDismiss;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UTPickerCollectionDataSource *pickerDataSource;

@end

@implementation UTAUDConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerDataSource = [UTPickerCollectionDataSource new];
    self.collectionView.dataSource = self.pickerDataSource;
    self.collectionView.delegate = self.pickerDataSource;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.pickerDataSource refreshWithNumberOfItems:5
                                collectionViewWidth:self.collectionView.frame.size.width
                                      customizeCell:^UICollectionViewCell *(UICollectionViewCell *cell, NSInteger index) {
                                          return cell;
                                      }];
    [self.pickerDataSource pageIndexDidUpdate:^(NSInteger index) {
        NSLog(@"%li", (long)index);
    }];
    
    [self.collectionView reloadData];
}

- (IBAction)didClickOnDismissButton:(id)sender {
    [self.fieldAUD resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.labelConverted.text = textField.text;
}

@end
