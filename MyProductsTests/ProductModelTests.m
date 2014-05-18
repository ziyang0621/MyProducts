//
//  ProductModelTests.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductModel.h"

@interface ProductModelTests : XCTestCase

@end

@implementation ProductModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Unit Test Methods
- (void)testProductModelCount {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqual(arrayTest.count, 3, @"Should have 3 models");
}

- (void)testProductModelUniqueIds {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:0]).uniqueId, @"1", @"Product one does not have correct uniqueId");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:1]).uniqueId, @"2", @"Product two does not have correct uniqueId");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:2]).uniqueId, @"3", @"Product three does not have correct uniqueId");
}

- (void)testProductModelNames {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:0]).name, @"shirt", @"Product one does not have correct name");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:1]).name, @"shoe", @"Product two does not have correct name");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:2]).name, @"glasses", @"Product three does not have correct name");
}

- (void)testProductModelDescriptions {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:0]).descriptionText, @"a demo shirt", @"Product one does not have correct description");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:1]).descriptionText, @"a demo shoe", @"Product two does not have correct description");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:2]).descriptionText, @"a demo glasses", @"Product three does not have correct description");
}

- (void)testProductModelRegPrices {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:0]).regPrice, [NSDecimalNumber decimalNumberWithString:@"50.09"], @"Product one does not have correct regular price");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:1]).regPrice, [NSDecimalNumber decimalNumberWithString:@"45.01"], @"Product two does not have correct regular price");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:2]).regPrice, [NSDecimalNumber decimalNumberWithString:@"20.05"], @"Product three does not have correct regular price");
}

- (void)testProductModelSalesPrices {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:0]).salesPrice, [NSDecimalNumber decimalNumberWithString:@"35.99"], @"Product one does not have correct sales price");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:1]).salesPrice, [NSDecimalNumber decimalNumberWithString:@"40.99"], @"Product two does not have correct sales price");
    XCTAssertEqualObjects(((ProductModel*)[arrayTest objectAtIndex:2]).salesPrice, [NSDecimalNumber decimalNumberWithString:@"10.99"], @"Product three does not have correct sales price");
}

- (void)testProductModelColors {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqual(((ProductModel*)[arrayTest objectAtIndex:0]).colors.count, 5, @"Product one does not have correct colors");
    XCTAssertEqual(((ProductModel*)[arrayTest objectAtIndex:1]).colors.count, 2, @"Product two does not have correct colors");
    XCTAssertEqual(((ProductModel*)[arrayTest objectAtIndex:2]).colors.count, 2, @"Product three does not have correct colors");
}

- (void)testProductModelStores {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    XCTAssertEqualObjects([((ProductModel*)[arrayTest objectAtIndex:0]).stores objectForKey:@"SF"], @10, @"SF should have correct amount");
    XCTAssertEqualObjects([((ProductModel*)[arrayTest objectAtIndex:0]).stores objectForKey:@"LA"], @2, @"LA should have correct amount");
    XCTAssertEqualObjects([((ProductModel*)[arrayTest objectAtIndex:0]).stores objectForKey:@"NY"], @5, @"NY should have correct amount");
}

@end
