//
//  NSNumber+CurrencyFormater.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import Foundation;

@interface NSNumber (CurrencyFormater)

- (NSString *)stringCurrencyAUD;
- (NSString *)stringCurrency:(NSString*)currencyCode;

@end
