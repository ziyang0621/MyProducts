//
//  ProductListViewController.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductTableViewCell.h"
#import "ProductModel.h"
#import "ProductDatabase.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController


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
    self.navigationItem.title = @"Product List";
    
    _currencyformatter = [[NSNumberFormatter alloc] init];
    [_currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

   
    [_tableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"ProductTableViewCell"];
    
    _productArray = [[ProductDatabase sharedDatabase] productInfoArray];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
    _tableView.contentSize = CGSizeMake(320.0f, 200.0f * _productArray.count);
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
}

#pragma mark - Memeory Warning Method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ProductDetailViewController Delegate Methods
- (void)productChanged:(ProductDetailViewController *)controller {
    _productArray = [[ProductDatabase sharedDatabase] productInfoArray];
    [_tableView reloadData];
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _productArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    productDetailVC.delegate = self;
    productDetailVC.selectedUniqueId = [((ProductModel*)[_productArray objectAtIndex:indexPath.row]).uniqueId copy];
    // Present View Controller
    [self.navigationController pushViewController:productDetailVC animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ProductTableViewCell";
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    ProductModel *model = [_productArray objectAtIndex:indexPath.row];
    cell.labelName.text = model.name;
    cell.labelDescription.text = model.descriptionText;
    cell.labelRegPrice.text = [NSString stringWithFormat:@"Reg Price: %@", [_currencyformatter stringFromNumber:model.regPrice]];
    cell.labelSalesPrice.text = [NSString stringWithFormat:@"Sales Price: %@", [_currencyformatter stringFromNumber:model.salesPrice]];
    cell.photo.image = model.photo;
    
    if ([model.regPrice compare:model.salesPrice] == NSOrderedDescending) {
        NSDecimalNumber *amountDiff = [model.regPrice decimalNumberBySubtracting:model.salesPrice];
        NSDecimalNumber *percentOff = [[amountDiff decimalNumberByDividingBy:model.regPrice] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100.00"]];
        if ([percentOff compare:[NSDecimalNumber decimalNumberWithString:@"1.00"]] == NSOrderedDescending) {
            cell.labelPercentOff.text = [NSString stringWithFormat:@"%.f%% Off", percentOff.floatValue];
        }
    }
    else {
        cell.labelPercentOff.hidden = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
