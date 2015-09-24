//
//  UTConverterTests.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import XCTest;
#import "UTRate.h"
#import "UTConverter.h"

@interface UTConverterTests : XCTestCase

@end

@implementation UTConverterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringFormatCurrency_AUD {
    NSString *string = [UTConverter stringCurrencyAUD:350];
    XCTAssertEqualObjects(string, @"$350.00");
}

- (void)testStringFormatCurrency_CAD {
    UTRate *rate = [UTRate createModelCurrency:@"CAD" ratio:@2];
    NSString *string = [UTConverter stringCurrencyAmount:350 toCurrencyRate:rate];
    XCTAssertEqualObjects(string, @"CA$700.00");
}

- (void)testStringFormatCurrency_EUR {
    UTRate *rate = [UTRate createModelCurrency:@"EUR" ratio:@2];
    NSString *string = [UTConverter stringCurrencyAmount:350 toCurrencyRate:rate];
    XCTAssertEqualObjects(string, @"€700.00");
}

- (void)testStringFormatCurrency_JPY {
    UTRate *rate = [UTRate createModelCurrency:@"JPY" ratio:@2];
    NSString *string = [UTConverter stringCurrencyAmount:350 toCurrencyRate:rate];
    XCTAssertEqualObjects(string, @"JP¥700");
}

- (void)testStringFormatCurrency_GBP {
    UTRate *rate = [UTRate createModelCurrency:@"GBP" ratio:@2];
    NSString *string = [UTConverter stringCurrencyAmount:350 toCurrencyRate:rate];
    XCTAssertEqualObjects(string, @"£700.00");
}

- (void)testStringFormatCurrency_USD {
    UTRate *rate = [UTRate createModelCurrency:@"USD" ratio:@2];
    NSString *string = [UTConverter stringCurrencyAmount:350 toCurrencyRate:rate];
    XCTAssertEqualObjects(string, @"US$700.00");
}


@end
