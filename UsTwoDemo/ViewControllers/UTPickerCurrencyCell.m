//
//  PickerCurrencyCell.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTPickerCurrencyCell.h"

@interface UTPickerCurrencyCell ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation UTPickerCurrencyCell

- (void)fillCellWithCurrency:(NSString *)currency {
    self.label.text = currency;
}

@end
