//
//  ProductDetailViewControllerTests.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductDetailViewController.h"
#import "ProductDatabase.h"
#import "ProductModel.h"

@interface ProductDetailViewControllerTests : XCTestCase

@property (nonatomic) ProductDetailViewController *productDetailVC;

@end

@implementation ProductDetailViewControllerTests

- (void)setUp {
    [super setUp];
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"productTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayTest = [ProductModel arrayOfModelsFromData:jsonData error:nil];
    if (![self hasProduct:@"1"]) {
        [[ProductDatabase sharedDatabase] insertProduct:[arrayTest objectAtIndex:0]];
    }
    _productDetailVC = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    _productDetailVC.selectedUniqueId = @"1";
    [_productDetailVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [_productDetailVC viewDidLoad];
}

- (void)tearDown {
    _productDetailVC = nil;
    [super tearDown];
}

#pragma mark - View loading tests
- (void)testThatViewLoads {
    XCTAssertNotNil(_productDetailVC.view, @"View not initiated properly");
}

- (void)testParentViewHasScrollViewSubview {
    NSArray *subviews = _productDetailVC.view.subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.scrollView], @"View does not have a scroll subview");
}

- (void)testThatScrollViewLoads {
    XCTAssertNotNil(_productDetailVC.scrollView, @"ScrollView not initiated");
}

#pragma mark - Scroll View Sub Views Tests
- (void)testProductNameTextFieldLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.textFieldProductName], @"View does not have a product name text field");

}

- (void)testProductDescriptionTextViewLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.textViewProductDescription], @"View does not have a product description text view");
}

- (void)testProductRegPriceTextFieldLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.textFieldProductRegPrice], @"View does not have a product regular price text field");
}

- (void)testProductSalesPriceTextFieldLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.textFieldProductSalesPrice], @"View does not have a product sales price text field");
}

- (void)testProductImageViewLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.imageViewproductPhoto], @"View does not have a product image view");
}

- (void)testProductStoresTableViewLoads {
    NSArray *subviews = ((UIScrollView*)_productDetailVC.scrollView).subviews;
    XCTAssertTrue([subviews containsObject:_productDetailVC.storesTableView], @"View does not have a product stores table view");
}

- (void)testProductStoresTableViewNumberOfRowsInSection {
      XCTAssertEqual([_productDetailVC tableView:_productDetailVC.storesTableView numberOfRowsInSection:0], 3, @"Table view should have correct rows");
}

- (void)testProductStoresTableViewHeightForRowAtIndexPath {
    CGFloat expectedHeight = 44.0;
    CGFloat actualHeight = _productDetailVC.storesTableView.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testProductStoresTableViewCellCreateCellsWithReuseIdentifier {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [_productDetailVC tableView:_productDetailVC.storesTableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = @"StoresTableViewCell";
    XCTAssertEqualObjects(cell.reuseIdentifier, expectedReuseIdentifier, @"Table does not create reusable cells");
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
