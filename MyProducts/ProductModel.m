//
//  ProductModel.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/16/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

#pragma mark - JSONModel Methods
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
           @"description": @"descriptionText",
           }];
}

@end
