//
//  ProductDatabase.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/16/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ProductModel.h"

@interface ProductDatabase : NSObject

@property (nonatomic) sqlite3 *database;

+ (ProductDatabase *)sharedDatabase;
- (NSArray *)productInfoArray;
- (ProductModel *)productDetail:(NSString *)uniqueId;
- (void)insertProduct:(ProductModel *)productModel;
- (void)updateProduct:(ProductModel *)productModel;
- (void)deleteProduct:(ProductModel *)productModel;

@end
