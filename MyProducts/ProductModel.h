//
//  ProductModel.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/16/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "JSONModel.h"

@interface ProductModel : JSONModel

@property (nonatomic) NSString *uniqueId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) NSDecimalNumber *regPrice;
@property (nonatomic) NSDecimalNumber *salesPrice;
@property (nonatomic) UIImage *photo;
@property (nonatomic) NSMutableArray *colors;
@property (nonatomic) NSMutableDictionary *stores;

@end
