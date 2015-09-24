//
//  UTAUDConverterViewControllerUITests.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

@import XCTest;

@interface UTAUDConverterViewControllerUITests : XCTestCase {
    XCUIApplication *app;
}

@end

@implementation UTAUDConverterViewControllerUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    
    app = [[XCUIApplication alloc] init];
    [app launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertedLabelFilledFromFieldAUD {
    
    XCUIElement *field = app.textFields[@"FieldAUD"];
    XCUIElement *label = app.staticTexts[@"LabelConverted"];
    XCUIElement *button = app.buttons[@"ButtonDismiss"];
    
    XCTAssertFalse(label.label.length, @"LabelConverted should be empty");
    [field tap];
    [field typeText:@"1234"];
    [button tap];
    XCTAssertTrue(label.label.length, @"LabelConverted should contain a string");
}

@end
