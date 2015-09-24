//
//  UTAUDConverterViewController.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTAUDConverterViewController.h"
#import "UTPickerCollectionDataSource.h"
#import "UTPickerCurrencyCell.h"
#import "UTWebservice.h"
#import "UTConverter.h"
#import "UTRate.h"
#import "NSNumber+CurrencyFormater.h"

@interface UTAUDConverterViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *fieldAUD;
@property (nonatomic, weak) IBOutlet UILabel *labelConverted;
@property (nonatomic, weak) IBOutlet UIButton *buttonDismiss;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *listRates;
@property (nonatomic, strong) UTPickerCollectionDataSource *pickerDataSource;
@property (nonatomic) NSInteger currentCurrency;
@property (nonatomic) double amountAUD;
@end

@implementation UTAUDConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fieldAUD.text = nil;
    self.labelConverted.text = nil;
    self.currentCurrency = 0;
    self.amountAUD = 0.0;
    
    self.pickerDataSource = [UTPickerCollectionDataSource new];
    self.collectionView.dataSource = self.pickerDataSource;
    self.collectionView.delegate = self.pickerDataSource;
    
    [self updateAUDCurrency];
}

#pragma mark - IBAction
- (IBAction)didClickOnDismissButton:(id)sender {
    [self.fieldAUD resignFirstResponder];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.amountAUD = textField.text.doubleValue;
    
    textField.text = [@(textField.text.doubleValue) stringCurrencyAUD];
    
    [self convertAUDAmount];
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self updateAUDCurrency];
}

#pragma mark - UTPickerCollection DataSource
- (void)refreshPicker {
    //  Replace the UICollectionView required delegate by block
    //--------------------------------------------------------------------------
    [self.pickerDataSource refreshWithNumberOfItems:self.listRates.count
                                collectionViewWidth:self.collectionView.frame.size.width
                                      customizeCell:^UICollectionViewCell *(UICollectionViewCell *cell, NSInteger index) {
                                          
                                          UTRate *rate = self.listRates[index];
                                          
                                          [(UTPickerCurrencyCell*)cell fillCellWithCurrency:rate.currency];
                                          return cell;
                                      }];
    
    //  Return the current index page after a scroll
    //--------------------------------------------------------------------------
    [self.pickerDataSource pageIndexDidUpdate:^(NSInteger index) {
        self.currentCurrency = index;
        [self convertAUDAmount];
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - Webservice
//
//  Update AUD rate from webservice
//------------------------------------------------------------------------------
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

#pragma mark - Converter
- (void)convertAUDAmount {
    UTRate *currentRate = self.listRates[self.currentCurrency];
    self.labelConverted.text = [UTConverter stringCurrencyAmount:self.amountAUD toCurrencyRate:currentRate];
}

@end
