//
//  UTAUDConverterViewController.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTAUDConverterViewController.h"
#import "UTPickerCollectionDataSource.h"
#import "UTWebservice.h"
#import "UTConverter.h"

@interface UTAUDConverterViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *fieldAUD;
@property (nonatomic, weak) IBOutlet UILabel *labelConverted;
@property (nonatomic, weak) IBOutlet UIButton *buttonDismiss;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *listRates;
@property (nonatomic, strong) UTPickerCollectionDataSource *pickerDataSource;

@end

@implementation UTAUDConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerDataSource = [UTPickerCollectionDataSource new];
    self.collectionView.dataSource = self.pickerDataSource;
    self.collectionView.delegate = self.pickerDataSource;
    
    [self updateAUDCurrency];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - IBAction
- (IBAction)didClickOnDismissButton:(id)sender {
    [self.fieldAUD resignFirstResponder];
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.labelConverted.text = textField.text;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self updateAUDCurrency];
}

#pragma mark - UTPickerCollection DataSource
- (void)refreshPicker {
    [self.pickerDataSource refreshWithNumberOfItems:self.listRates.count
                                collectionViewWidth:self.collectionView.frame.size.width
                                      customizeCell:^UICollectionViewCell *(UICollectionViewCell *cell, NSInteger index) {
                                          return cell;
                                      }];
    [self.pickerDataSource pageIndexDidUpdate:^(NSInteger index) {
        NSLog(@"%li", (long)index);
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - Webservice
- (void)updateAUDCurrency {
    [[UTWebservice sharedManager] getCurrencyAUDRates:^(NSArray<UTRate *> *listRates) {
        self.listRates = listRates;
        
        if (self.listRates) {
            [self refreshPicker];
        } else {
            [[[UIAlertView alloc] initWithTitle:@""
                                        message:@"Sorry, we cannot retrieve AUD rate,\nTry again ?"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

@end
