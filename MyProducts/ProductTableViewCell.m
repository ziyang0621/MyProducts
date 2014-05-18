//
//  ProductTableViewCell.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _labelName.shadowColor  = [UIColor whiteColor];
    _labelName.shadowOffset = CGSizeMake(0.4f, 0.4f);
    
    _labelDescription.textColor = [UIColor colorFromHexString:@"#898C90"];
    _labelDescription.shadowColor = [UIColor whiteColor];
    _labelDescription.shadowOffset = CGSizeMake(0.4f, 0.4f);

    _labelRegPrice.shadowColor = [UIColor whiteColor];
    _labelRegPrice.shadowOffset = CGSizeMake(0.4f, 0.4f);
    
    _labelSalesPrice.textColor = [UIColor colorFromHexString:@"#FF5E3A"];
    _labelSalesPrice.shadowColor = [UIColor whiteColor];
    _labelSalesPrice.shadowOffset = CGSizeMake(0.4f, 0.4f);
    
    _labelPercentOff.backgroundColor = [UIColor colorFromHexString:@"#FF5E3A"];
    _labelPercentOff.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
