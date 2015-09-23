//
//  UTRate.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTRate.h"
#import "Constantes.h"

@implementation UTRate

+ (UTRate *)createModelCurrency:(NSString *)currency ratio:(NSNumber *)ratio {
    
    UTRate *model = nil;
    if (StringNotNull(currency) && NumberNotNull(ratio)) {
        model = [UTRate new];
        model.currency = currency;
        model.ratio = ratio;
    }
    
    return model;
}

@end
