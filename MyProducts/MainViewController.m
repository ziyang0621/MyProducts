//
//  MainViewController.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "MainViewController.h"
#import "ProductModel.h"
#import "SVProgressHUD.h"
#import "ProductListViewController.h"
#import "ProductDatabase.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - Init Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecylce Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Welcome";
    
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    _productJSONArray = [ProductModel arrayOfModelsFromData:jsonData error:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(320.0f, 568.0f);
    _scrollView.frame = self.view.frame;
}

#pragma makr - Ultilities Methods
- (void)setUpView {
    //Setup show product button
    UIButton *buttonShowProducts = [[UIButton alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.frame) - 80.0f, CGRectGetMinY(self.view.frame) + 30.0f, 160.0f, 40.0f)];
    [buttonShowProducts setTitle: @"Show Products" forState:UIControlStateNormal];
    buttonShowProducts.layer.cornerRadius = CGRectGetHeight(buttonShowProducts.frame) /2;
    buttonShowProducts.layer.borderWidth = 1.0f;
    buttonShowProducts.clipsToBounds = YES;
    UIColor *showProductBtnColor = [UIColor colorFromHexString:@"#898C90"];
    buttonShowProducts.layer.borderColor = showProductBtnColor.CGColor;
    buttonShowProducts.tintColor = showProductBtnColor;
    buttonShowProducts.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    [buttonShowProducts setTitleColor:showProductBtnColor forState:UIControlStateNormal];
    [buttonShowProducts addTarget:self action:@selector(showProductsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonShowProducts];
    
    //Setup create product buttons
    for (int i = 0; i < _productJSONArray.count; i++) {
        UIButton *buttonCreateProduct = [[UIButton alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.frame) - 80.0f, CGRectGetMaxY(buttonShowProducts.frame) + 30.0f * (i + 1) + 40.0f *i, 160.0f, 40.0f)];
        buttonCreateProduct.tag = i;
        [buttonCreateProduct setTitle: [NSString stringWithFormat:@"Create Product %d", i+1] forState:UIControlStateNormal];
        buttonCreateProduct.layer.cornerRadius = CGRectGetHeight(buttonCreateProduct.frame) /2;
        buttonCreateProduct.layer.borderWidth = 1.0f;
        buttonCreateProduct.clipsToBounds = YES;
        UIColor *createProductBtnColor = [UIColor colorFromHexString:@"#FF5E3A"];
        buttonCreateProduct.layer.borderColor = createProductBtnColor.CGColor;
        buttonCreateProduct.tintColor = createProductBtnColor;
        buttonCreateProduct.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        [buttonCreateProduct setTitleColor:createProductBtnColor forState:UIControlStateNormal];
        [buttonCreateProduct addTarget:self action:@selector(createProductButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:buttonCreateProduct];
    }
}

#pragma mark - Button Pressed Methods
- (void)showProductsButtonPressed {
    ProductListViewController *productListVC = [[ProductListViewController alloc] initWithNibName:@"ProductListViewController" bundle:nil];
    // Present View Controller
    [self.navigationController pushViewController:productListVC animated:YES];
}

- (void)createProductButtonPressed:(UIButton*)button {
    [[ProductDatabase sharedDatabase] insertProduct:[_productJSONArray objectAtIndex:button.tag]];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Product %d Created", button.tag + 1]];
}


#pragma mark - Memeory Warning Method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
