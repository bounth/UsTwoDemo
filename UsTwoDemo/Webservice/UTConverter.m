//
//  Converter.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTConverter.h"
#import "UTRate.h"
#import "NSNumber+CurrencyFormater.h"

@implementation UTConverter

+ (NSString *)stringCurrencyAUD:(double)amount {
    return [UTConverter stringCurrencyAmount:amount toCurrency:@"AUD" withRatio:1];
}

+ (NSString *)stringCurrencyAmount:(double)amount toCurrencyRate:(UTRate *)rate {
    return [UTConverter stringCurrencyAmount:amount
                                  toCurrency:rate.currency
                                   withRatio:rate.ratio.doubleValue];
}

+ (NSString *)stringCurrencyAmount:(double)amount
                        toCurrency:(NSString *)currency
                         withRatio:(double)ratio {
    
    return [@(amount * ratio) stringCurrency:currency];
}


@end
