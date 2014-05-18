//
//  MainViewController.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSArray *productJSONArray;
@property (nonatomic) NSArray *createdProductArray;
@end
