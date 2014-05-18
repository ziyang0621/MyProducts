//
//  ProductDetailViewController.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDatabase.h"
#import "StoresTableViewCell.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SVProgressHUD.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

#pragma mark - Init Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle Mehtods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Product Detail";
    
    _storesTableView.delegate = self;
    _storesTableView.dataSource = self;

    [_storesTableView registerNib:[UINib nibWithNibName:@"StoresTableViewCell"
                                           bundle:[NSBundle mainBundle]]
     forCellReuseIdentifier:@"StoresTableViewCell"];
    
    _productModel = [[ProductDatabase sharedDatabase] productDetail:_selectedUniqueId];
    
  //  [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpView];
}


- (void)viewDidAppear:(BOOL)animiated {
    [super viewDidAppear:animiated];
    
    //Adjust Stores Tableview and Scroll after View did appear
//    _storesTableView.frame = CGRectMake(20.0f, CGRectGetMinY(_storesTableView.frame), 280.0f, CGRectGetHeight(_storesTableView.frame));
    _scrollView.contentSize = CGSizeMake(320.0f, CGRectGetMaxY(_storesTableView.frame) + 20.0f);
}

#pragma mark - Utilities Methods
- (void)setUpView {
    //Setup Product Name TextField
    _textFieldProductName.text = [_productModel.name copy];

    //Setup Product Description TextView
    [_textViewProductDescription.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor]];
    [_textViewProductDescription.layer setBorderWidth:1.0f];
    _textViewProductDescription.layer.cornerRadius = 5.0f;
    _textViewProductDescription.clipsToBounds = YES;
    _textViewProductDescription.text = [_productModel.descriptionText copy];
    
    //Setup Product Price TextFields
    _textFieldProductRegPrice.text = _productModel.regPrice.stringValue;
    _textFieldProductSalesPrice.text = _productModel.salesPrice.stringValue;
    
    //Setup Product Photo TextField
    _imageViewproductPhoto.image = _productModel.photo;
    _imageViewproductPhoto.layer.cornerRadius = CGRectGetHeight(_imageViewproductPhoto.frame) /2;
    _imageViewproductPhoto.layer.borderWidth = 1.0f;
    _imageViewproductPhoto.layer.borderColor = [UIColor colorFromHexString:@"#D7D7D7"].CGColor;
    _imageViewproductPhoto.clipsToBounds = YES;
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewTap)];
    _imageViewproductPhoto.userInteractionEnabled = YES;
    [_imageViewproductPhoto addGestureRecognizer:imageViewTap];
    
    //Setup Product Colors Label
    UILabel *labelColors = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, CGRectGetMaxY(_textFieldProductSalesPrice.frame) + 10.0f, 100.0f, 20.0f)];
    labelColors.text = @"Colors:";
    labelColors.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    [_scrollView addSubview:labelColors];
    
    //Setup Product Colors Views
    int i = 0;
    float minY = CGRectGetMinY(labelColors.frame);
    float maxY = CGRectGetMaxY(labelColors.frame);
    for (NSString *hexString in _productModel.colors) {
        UIView *viewColor;
        int modVal = i % 4;
        if (modVal != 0) {
            viewColor = [[UIView alloc] initWithFrame:CGRectMake(100 + (modVal - 1) * 60.0f, minY, 40.0f, 30.0f)];
        }
        else {
            viewColor = [[UIView alloc] initWithFrame:CGRectMake(40.0f, maxY + 10.0f, 40.0f, 30.0f)];
        }
        viewColor.backgroundColor = [UIColor colorFromHexString:hexString];
        [_scrollView addSubview:viewColor];
        minY = CGRectGetMinY(viewColor.frame);
        maxY = CGRectGetMaxY(viewColor.frame);
        i ++;
    }
    
    //Setup Product Stores Label
    UILabel *labelStores = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, maxY + 10.0f, 100.0f, 20.0f)];
    labelStores.text = @"Stores:";
    labelStores.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    [_scrollView addSubview:labelStores];
    
    //Setup Product Stores Table
    _storesTableView.frame = CGRectMake(20.0f, CGRectGetMaxY(labelStores.frame) + 10.0f, 280.0f, 44.0f * [[_productModel.stores allKeys] count]);
    _storesTableView.contentSize = CGSizeMake(320.0f, 44.0f * [[_productModel.stores allKeys] count]);
    _storesTableView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor];
    _storesTableView.layer.borderWidth = 1.0f;
    _storesTableView.layer.cornerRadius = 5.0f;
    _storesTableView.clipsToBounds = YES;
    
    //Setup Product Update Button
    UIColor *buttonColor = [UIColor colorFromHexString:@"#FF5E3A"];
    _buttonUpdate.layer.cornerRadius = CGRectGetHeight(_buttonUpdate.frame) /2;
    _buttonUpdate.layer.borderWidth = 1.0f;
    _buttonUpdate.layer.borderColor = buttonColor.CGColor;
    [_buttonUpdate setTitleColor:buttonColor forState:UIControlStateNormal];
    [_buttonUpdate addTarget:self action:@selector(handleUpdateButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    //Setup Product Delete Buton
    _buttonDelete.layer.cornerRadius = CGRectGetHeight(_buttonDelete.frame) /2;
    _buttonDelete.layer.borderWidth = 1.0f;
    _buttonDelete.layer.borderColor = buttonColor.CGColor;
    [_buttonDelete setTitleColor:buttonColor forState:UIControlStateNormal];
    [_buttonDelete addTarget:self action:@selector(handleDeleteButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    //Setup Divider Line
    UIView *viewDivider = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMinY(_buttonUpdate.frame) - 15.0f, 320.0f, 1.0f)];
    viewDivider.backgroundColor = buttonColor;
    [self.view addSubview:viewDivider];
    
    //Setup Scroll View
    UITapGestureRecognizer *scrollViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScrollViewTap)];
    [_scrollView addGestureRecognizer:scrollViewTap];
}

#pragma mark - Gestures Handling Methods
- (void)handleUpdateButtonTap {
    ProductModel *newModel = [[ProductModel alloc] init];
    newModel.uniqueId = [_productModel.uniqueId copy];
    newModel.name = [_textFieldProductName.text copy];
    newModel.descriptionText = [_textViewProductDescription.text copy];
    newModel.regPrice = [NSDecimalNumber decimalNumberWithDecimal:[_textFieldProductRegPrice.amount decimalValue]];
    newModel.salesPrice = [NSDecimalNumber decimalNumberWithDecimal:[_textFieldProductSalesPrice.amount decimalValue]];
    newModel.photo = _imageViewproductPhoto.image;
    newModel.colors = [_productModel.colors copy];
    newModel.stores = [[NSMutableDictionary alloc] init];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    for (StoresTableViewCell *cell in [_storesTableView visibleCells]) {
        NSNumber *amount = [formatter numberFromString:cell.textFieldAmount.text];
        [newModel.stores setObject:amount forKey:cell.labelCity.text];
    }
    
    [[ProductDatabase sharedDatabase] updateProduct:newModel];
    [SVProgressHUD showSuccessWithStatus:@"Product Updated"];
    [self.delegate productChanged:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleDeleteButtonTap {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Are you sure to delete this product?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Yes, Delete"
                                  otherButtonTitles:nil];
    
    [actionSheet showInView:self.navigationController.view];
}

- (void)handleImageViewTap {
    MXLMediaView *mediaView = [[MXLMediaView alloc] init];
    [mediaView setDelegate:self];
    
    [mediaView showImage:_productModel.photo inParentView:self.navigationController.view completion:^{
        NSLog(@"Done showing MXLMediaView");
    }];
}

- (void)handleScrollViewTap {
    [_scrollView endEditing: YES];
}

#pragma mark - UIActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes, Delete"]) {
        [[ProductDatabase sharedDatabase] deleteProduct:_productModel];
        [SVProgressHUD showSuccessWithStatus:@"Product Deleted"];
        [self.delegate productChanged:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_productModel.stores allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StoresTableViewCell";
    StoresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    int i = 0;
    for (NSString *cityKey in [_productModel.stores allKeys]) {
        if (i == indexPath.row) {
            cell.labelCity.text = cityKey;
            cell.textFieldAmount.text = [NSString stringWithFormat:@"%d", ((NSNumber*)[_productModel.stores objectForKey:cityKey]).intValue];
            break;
        }
        i++;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - MXLMediaView Delegate Methods
-(void)mediaView:(MXLMediaView *)mediaView didReceiveLongPressGesture:(id)gesture {
    NSLog(@"MXLMediaViewDelgate: Long pressed received");
}

-(void)mediaViewWillDismiss:(MXLMediaView *)mediaView {
    NSLog(@"MXLMediaViewDelgate: Will dismiss");
}

-(void)mediaViewDidDismiss:(MXLMediaView *)mediaView {
    NSLog(@"MXLMediaViewDelgate: Did dismiss");
}

#pragma mark - Memeory Warning Method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end