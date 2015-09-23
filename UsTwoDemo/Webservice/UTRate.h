//
//  UTRate.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import Foundation;

@interface UTRate : NSObject

@property (nonatomic, strong) NSNumber *ratio;
@property (nonatomic, copy) NSString *currency;

+ (UTRate *)createModelCurrency:(NSString *)currency ratio:(NSNumber *)ratio;

@end
