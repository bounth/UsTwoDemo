//
//  Converter.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import Foundation;

@class  UTRate;

@interface UTConverter : NSObject

+ (NSString *)stringCurrencyAUD:(double)amount;
+ (NSString *)stringCurrencyAmount:(double)amount toCurrencyRate:(UTRate *)rate;

@end
