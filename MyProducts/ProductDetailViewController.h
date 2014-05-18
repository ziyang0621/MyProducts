//
//  ProductDetailViewController.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "MXLMediaView.h"
#import "TSCurrencyTextField.h"
@class TPKeyboardAvoidingScrollView;

@protocol ProductDetailViewControllerDelegate;

@interface ProductDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UITextFieldDelegate, MXLMediaViewDelegate>

@property id<ProductDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewproductPhoto;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProductName;
@property (weak, nonatomic) IBOutlet UITextView *textViewProductDescription;
@property (weak, nonatomic) IBOutlet TSCurrencyTextField *textFieldProductRegPrice;
@property (weak, nonatomic) IBOutlet TSCurrencyTextField *textFieldProductSalesPrice;
@property (weak, nonatomic) IBOutlet UITableView *storesTableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpdate;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (nonatomic) NSString *selectedUniqueId;
@property (nonatomic) ProductModel *productModel;
@end

@protocol ProductDetailViewControllerDelegate <NSObject>
- (void)productChanged:(ProductDetailViewController *)controller;

@end
