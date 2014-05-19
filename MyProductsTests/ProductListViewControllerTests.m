//
//  ProductListViewControllerTests.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductListViewController.h"

@interface ProductListViewControllerTests : XCTestCase

@property (nonatomic) ProductListViewController *productListVC;

@end

@implementation ProductListViewControllerTests

- (void)setUp {
    [super setUp];
    _productListVC = [[ProductListViewController alloc] initWithNibName:@"ProductListViewController" bundle:nil];
    [_productListVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [_productListVC viewDidLoad];
}

- (void)tearDown {
    
    _productListVC = nil;
    [super tearDown];
}

#pragma mark - View loading tests
- (void)testThatViewLoads {
    XCTAssertNotNil(_productListVC.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview {
    NSArray *subviews = _productListVC.view.subviews;
    XCTAssertTrue([subviews containsObject:_productListVC.tableView], @"View does not have a table subview");
}

-(void)testThatTableViewLoads {
    XCTAssertNotNil(_productListVC.tableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource {
    XCTAssertTrue([_productListVC conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource {
    XCTAssertNotNil(_productListVC.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate {
    XCTAssertTrue([_productListVC conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate {
    XCTAssertNotNil(_productListVC.tableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection {
    XCTAssertEqual([_productListVC tableView:_productListVC.tableView numberOfRowsInSection:0], _productListVC.productArray.count, @"Table view should have correct rows");
}

- (void)testTableViewHeightForRowAtIndexPath {
    CGFloat expectedHeight = 200.0;
    CGFloat actualHeight = _productListVC.tableView.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [_productListVC tableView:_productListVC.tableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = @"ProductTableViewCell";
    XCTAssertEqualObjects(cell.reuseIdentifier, expectedReuseIdentifier, @"Table does not create reusable cells");
}

@end
