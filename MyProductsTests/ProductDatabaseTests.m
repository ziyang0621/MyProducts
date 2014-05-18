//
//  ProductDatabaseTests.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductModel.h"
#import "ProductDatabase.h"

@interface ProductDatabaseTests : XCTestCase

@end

@implementation ProductDatabaseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Unit Test Methods
- (void)testDatabaseDelete {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    
    if (![self hasProduct:@"1"]) {
        [[ProductDatabase sharedDatabase] insertProduct:[arrayTest objectAtIndex:0]];
    }
    [[ProductDatabase sharedDatabase] deleteProduct:[arrayTest objectAtIndex:0]];
    
    XCTAssertFalse([self hasProduct:@"1"], "Should deleted product");
}

- (void)testDatabaseInsert {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    
    if ([self hasProduct:@"1"]) {
        [[ProductDatabase sharedDatabase] deleteProduct:[arrayTest objectAtIndex:0]];
    }
    [[ProductDatabase sharedDatabase] insertProduct:[arrayTest objectAtIndex:0]];
    
    XCTAssertTrue([self hasProduct:@"1"], "Should inserted product");
}

- (void)testDatabaseUpdate {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    
    if (![self hasProduct:@"1"]) {
        [[ProductDatabase sharedDatabase] insertProduct:[arrayTest objectAtIndex:0]];
    }
    ProductModel *newModel = [arrayTest objectAtIndex:0];
    NSString *newName = [NSString stringWithFormat:@"%@ test", newModel.name];
    newModel.name = newName;
    
    [[ProductDatabase sharedDatabase] updateProduct:newModel];
    
    NSString *newTestName = ((ProductModel*)[[ProductDatabase sharedDatabase] productDetail:newModel.uniqueId]).name;
    XCTAssertEqualObjects(newName, newTestName, @"Should updated product");
}

- (void)testDatabaseSelect {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];

    if (![self hasProduct:@"1"]) {
        [[ProductDatabase sharedDatabase] insertProduct:[arrayTest objectAtIndex:0]];
    }
    
    XCTAssertNotNil([[ProductDatabase sharedDatabase] productDetail:@"1"], @"Should selected a product");
    
}

#pragma mark - Utilities Methods
- (BOOL)hasProduct:(NSString*)uniqueId {
    NSArray *arrayTest = [[ProductDatabase sharedDatabase] productInfoArray];
    for (ProductModel *model in arrayTest) {
        if ([model.uniqueId isEqualToString:uniqueId]) {
            return YES;
        }
    }
    return NO;
}

@end
