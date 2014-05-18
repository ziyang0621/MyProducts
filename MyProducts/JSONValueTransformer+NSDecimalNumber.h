//
//  JSONValueTransformer+NSDecimalNumber.h
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONValueTransformer.h"

@interface JSONValueTransformer(NSDecimalNumber) 

- (NSDecimalNumber *)NSDecimalNumberFromNSNumber:(NSNumber *)value;

@end
