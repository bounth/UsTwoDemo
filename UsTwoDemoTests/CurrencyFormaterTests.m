//
//  CurrencyFormaterTests.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import XCTest;
#import "NSNumber+CurrencyFormater.h"

@interface CurrencyFormaterTests : XCTestCase

@end

@implementation CurrencyFormaterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCurrencyFormatAUD_Credit {
    NSNumber *amount = @345;
    XCTAssertEqualObjects([amount stringCurrency:@"AUD"], @"$345.00");
}

- (void)testCurrencyFormatAUD_Debit {
    NSNumber *amount = @(-345);
    XCTAssertEqualObjects([amount stringCurrency:@"AUD"], @"-$345.00");
}

- (void)testCurrencyFormatAUD_Cents {
    NSNumber *amount = @345.673;
    XCTAssertEqualObjects([amount stringCurrency:@"AUD"], @"$345.67");
}

- (void)testCurrencyFormatEUR_Credit {
    NSNumber *amount = @345;
    XCTAssertEqualObjects([amount stringCurrency:@"EUR"], @"€345.00");
}

- (void)testCurrencyFormatEUR_Debit {
    NSNumber *amount = @(-345);
    XCTAssertEqualObjects([amount stringCurrency:@"EUR"], @"-€345.00");
}

- (void)testCurrencyFormatEUR_Cents {
    NSNumber *amount = @345.673;
    XCTAssertEqualObjects([amount stringCurrency:@"EUR"], @"€345.67");
}

- (void)testCurrencyFormatUSD_Credit {
    NSNumber *amount = @345;
    XCTAssertEqualObjects([amount stringCurrency:@"USD"], @"US$345.00");
}

- (void)testCurrencyFormatUSD_Debit {
    NSNumber *amount = @(-345);
    XCTAssertEqualObjects([amount stringCurrency:@"USD"], @"-US$345.00");
}

- (void)testCurrencyFormatUSD_Cents {
    NSNumber *amount = @345.673;
    XCTAssertEqualObjects([amount stringCurrency:@"USD"], @"US$345.67");
}

@end
