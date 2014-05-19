//
//  MainViewControllerTests.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MainViewController.h"

@interface MainViewControllerTests : XCTestCase

@property (nonatomic) MainViewController *mainVC;

@end

@implementation MainViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    _mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [_mainVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [_mainVC viewDidLoad];
    [_mainVC viewWillAppear:NO];
}

- (void)tearDown {
    _mainVC = nil;
    [super tearDown];
}

#pragma mark - View loading tests
- (void)testThatViewLoads {
    XCTAssertNotNil(_mainVC.view, @"View not initiated properly");
}

- (void)testParentViewHasScrollViewSubview {
    NSArray *subviews = _mainVC.view.subviews;
    XCTAssertTrue([subviews containsObject:_mainVC.scrollView], @"View does not have a scroll subview");
}

- (void)testThatScrollViewLoads {
    XCTAssertNotNil(_mainVC.scrollView, @"ScrollView not initiated");
}

- (void)testButtonsLoads {
    NSArray *subviews = ((UIScrollView*)_mainVC.scrollView).subviews;
    int totalButtons = 0;
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            totalButtons ++;
        }
    }
    XCTAssertEqual(totalButtons, _mainVC.productJSONArray.count + 1, @"View does not have all buttons");
}

@end
