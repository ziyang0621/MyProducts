//
//  ProductTableViewCell.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelRegPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelSalesPrice;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@end
