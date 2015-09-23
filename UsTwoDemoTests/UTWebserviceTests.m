//
//  UTWebserviceTests.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import XCTest;
#import "UTWebservice.h"

@interface UTWebserviceTests : XCTestCase

@end

@implementation UTWebserviceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCurrencyAUDRate {
    
    XCTestExpectation *USDRateExpectation = [self expectationWithDescription:@"get USD exchange rate"];
    
    [[UTWebservice sharedManager] getCurrencyAUDRates:^(NSArray <UTRate *> *listRates) {
        
        // Test returned object
        XCTAssertTrue([listRates isKindOfClass:[NSArray class]], @"Should return a NSArray");
        
        // Test rates and contains CAD, EUR, GBP, JPY, USD
        XCTAssertNotNil([self getCurrencyRate:@"CAD" ratesList:listRates], @"Rates should contain CAD currency");
        XCTAssertNotNil([self getCurrencyRate:@"EUR" ratesList:listRates], @"Rates should contain EUR currency");
        XCTAssertNotNil([self getCurrencyRate:@"GBP" ratesList:listRates], @"Rates should contain GBP currency");
        XCTAssertNotNil([self getCurrencyRate:@"JPY" ratesList:listRates], @"Rates should contain JPY currency");
        XCTAssertNotNil([self getCurrencyRate:@"USD" ratesList:listRates], @"Rates should contain USD currency");
        
        [USDRateExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"testGetCurrencyAUDRate Error : %@", error);
        }
    }];
}

- (NSDictionary*)getCurrencyRate:(NSString*)currency ratesList:(NSArray*)rates {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"currency LIKE %@", currency];
    NSArray *filtered = [rates filteredArrayUsingPredicate:predicate];
    if (filtered.count) {
        return [filtered lastObject];
    }
    return nil;
}
@end
