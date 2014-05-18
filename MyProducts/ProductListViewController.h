//
//  ProductListViewController.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewController.h"

@interface ProductListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ProductDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *productArray;
@property (nonatomic) NSNumberFormatter *currencyformatter;

@end
