//
//  UTWebservice.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import Foundation;

@class UTRate;

typedef void (^UTGetCurrencyList)(NSArray <UTRate *> *listRates);

@interface UTWebservice : NSObject

+ (instancetype)sharedManager;

- (void)getCurrencyAUDRates:(UTGetCurrencyList)completionBlock;

@end
