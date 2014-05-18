//
//  JSONValueTransformer+NSDecimalNumber.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "JSONValueTransformer+NSDecimalNumber.h"

@implementation JSONValueTransformer(NSDecimalNumber) 

- (NSDecimalNumber *)NSDecimalNumberFromNSNumber:(NSNumber *)value {
    return [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
}

@end
