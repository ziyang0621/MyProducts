//
//  JSONValueTransformer+UIImage.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/17/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "JSONValueTransformer+UIImage.h"

@implementation JSONValueTransformer(UIImage)

- (UIImage *)UIImageFromNSString:(NSString *)string {
    return [UIImage imageNamed:string];
}

@end
