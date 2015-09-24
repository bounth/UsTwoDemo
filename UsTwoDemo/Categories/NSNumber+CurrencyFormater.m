//
//  NSNumber+CurrencyFormater.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "NSNumber+CurrencyFormater.h"

@implementation NSNumber (CurrencyFormater)

//
//  Return a string currency format
//  --> $230.00
//------------------------------------------------------------------------------

- (NSString *)stringCurrencyAUD {
    return [self stringCurrency:@"AUD"];
}

- (NSString *)stringCurrency:(NSString*)currencyCode {
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_AU"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setLocale:locale];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencyCode:currencyCode];
    
    return [numberFormatter stringFromNumber:self];
}

@end
