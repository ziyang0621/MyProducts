//
//  ProductDatabase.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/16/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "ProductDatabase.h"

@implementation ProductDatabase

#pragma mark - Init Methods
+ (ProductDatabase*)sharedDatabase {
    static ProductDatabase *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if ((self = [super init])) {
    }
    return self;
}


#pragma mark - Utilities Methods
-(NSString*)getDocumentPath {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"sqlite"];
    
    NSString *documentsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *documentsPath   = [[documentsFolder stringByAppendingPathComponent:@"product"] stringByAppendingPathExtension:@"sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:documentsPath]) {
        NSError *error = nil;
        BOOL success = [fileManager copyItemAtPath:bundlePath toPath:documentsPath error:&error];
        NSAssert(success, @"%s: copyItemAtPath failed: %@", __FUNCTION__, error);
    }
    
    return documentsPath;
}

//- (NSString *)generateUniqueId {
//    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
//    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
//    CFRelease(uuidRef);
//    return (__bridge NSString *)uuidStringRef;
//}


#pragma mark - Database Methods
- (NSArray *)productInfoArray {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT * FROM productTable";
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self getDocumentPath] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            ProductModel *model = [[ProductModel alloc] init];
            char *uniqueId = (char *) sqlite3_column_text(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *decriptionChars = (char *) sqlite3_column_text(statement, 2);
            double regPriceDouble = sqlite3_column_double(statement, 3);
            double salesPriceDouble = sqlite3_column_double(statement, 4);
            const char *rawPhotoData = sqlite3_column_blob(statement, 5);
            int rawPhotoLength = sqlite3_column_bytes(statement, 5);
            NSData *photoData = [NSData dataWithBytes:rawPhotoData length:rawPhotoLength];
            const char *rawColorsData = sqlite3_column_blob(statement, 6);
            int rawColorsLength = sqlite3_column_bytes(statement, 6);
            NSData *colorsData = [NSData dataWithBytes:rawColorsData length:rawColorsLength];
            const char *rawStoresData = sqlite3_column_blob(statement, 7);
            int rawStoresLength = sqlite3_column_bytes(statement, 7);
            NSData *storesData = [NSData dataWithBytes:rawStoresData length:rawStoresLength];
            
            model.uniqueId = [[NSString alloc] initWithUTF8String:uniqueId];
            model.name = [[NSString alloc] initWithUTF8String:nameChars];
            model.descriptionText = [[NSString alloc] initWithUTF8String: decriptionChars];
            model.regPrice = [[NSDecimalNumber alloc] initWithDouble:regPriceDouble];
            model.salesPrice = [[NSDecimalNumber alloc] initWithDouble:salesPriceDouble];
            model.photo = [UIImage imageWithData:photoData];
            model.colors = [NSKeyedUnarchiver unarchiveObjectWithData:colorsData];
            model.stores = [NSKeyedUnarchiver unarchiveObjectWithData:storesData];
            
            [retval addObject:model];
        }
        // Execute the statement.
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"select error");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    return retval;
}


- (ProductModel *)productDetail:(NSString*)uniqueId {
    ProductModel *model =  [[ProductModel alloc] init];
    NSString *query = [NSString stringWithFormat: @"SELECT * FROM productTable WHERE uniqueId =%@", uniqueId];
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self getDocumentPath] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *uniqueId = (char *) sqlite3_column_text(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *decriptionChars = (char *) sqlite3_column_text(statement, 2);
            double regPriceDouble = sqlite3_column_double(statement, 3);
            double salesPriceDouble = sqlite3_column_double(statement, 4);
            const char *rawPhotoData = sqlite3_column_blob(statement, 5);
            int rawPhotoLength = sqlite3_column_bytes(statement, 5);
            NSData *photoData = [NSData dataWithBytes:rawPhotoData length:rawPhotoLength];
            const char *rawColorsData = sqlite3_column_blob(statement, 6);
            int rawColorsLength = sqlite3_column_bytes(statement, 6);
            NSData *colorsData = [NSData dataWithBytes:rawColorsData length:rawColorsLength];
            const char *rawStoresData = sqlite3_column_blob(statement, 7);
            int rawStoresLength = sqlite3_column_bytes(statement, 7);
            NSData *storesData = [NSData dataWithBytes:rawStoresData length:rawStoresLength];
            
            model.uniqueId = [[NSString alloc] initWithUTF8String:uniqueId];
            model.name = [[NSString alloc] initWithUTF8String:nameChars];
            model.descriptionText = [[NSString alloc] initWithUTF8String: decriptionChars];
            model.regPrice = [[NSDecimalNumber alloc] initWithDouble:regPriceDouble];
            model.salesPrice = [[NSDecimalNumber alloc] initWithDouble:salesPriceDouble];
            model.photo = [UIImage imageWithData:photoData];
            model.colors = [NSKeyedUnarchiver unarchiveObjectWithData:colorsData];
            model.stores = [NSKeyedUnarchiver unarchiveObjectWithData:storesData];
        }
        // Execute the statement.
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"select single error");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    return model;
}


- (void)insertProduct:(ProductModel *)productModel {
    NSString *query = @"INSERT INTO `productTable` (`uniqueId`, `name`, 'description', 'regPrice', 'salesPrice', 'photo', 'colors', 'stores') VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    sqlite3_stmt *statement;

    if (sqlite3_open([[self getDocumentPath] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {

        sqlite3_bind_text(statement, 1, [productModel.uniqueId UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [productModel.name UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 3, [productModel.descriptionText UTF8String], -1, NULL);
        sqlite3_bind_double(statement, 4, [productModel.regPrice doubleValue]);
        sqlite3_bind_double(statement, 5, [productModel.salesPrice doubleValue]);
        
        NSData *imageData = UIImagePNGRepresentation(productModel.photo);
        sqlite3_bind_blob(statement, 6, [imageData bytes], [imageData length], NULL);
        
        NSData *colorsData = [NSKeyedArchiver archivedDataWithRootObject:productModel.colors];
        sqlite3_bind_blob(statement, 7, [colorsData bytes], [colorsData length], NULL);
        
        NSData *storesData = [NSKeyedArchiver archivedDataWithRootObject:productModel.stores];
        sqlite3_bind_blob(statement, 8, [storesData bytes], [storesData length], NULL);
    }
    else {
        NSLog(@"insert prepare error");
    }
    
    // Execute the statement.
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSLog(@"insert error");
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(_database);
}

- (void)updateProduct:(ProductModel *)productModel {
    NSString *query = @"UPDATE productTable Set name = ?, description = ?, regPrice = ?, salesPrice = ?, photo = ?, colors = ?, stores = ? WHERE uniqueId = ?";
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self getDocumentPath] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [productModel.name UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [productModel.descriptionText UTF8String], -1, NULL);
        sqlite3_bind_double(statement, 3, [productModel.regPrice doubleValue]);
        sqlite3_bind_double(statement, 4, [productModel.salesPrice doubleValue]);
        
        NSData *photoData = UIImagePNGRepresentation(productModel.photo);
        sqlite3_bind_blob(statement, 5, [photoData bytes], [photoData length], NULL);
        
        NSData *colorsData = [NSKeyedArchiver archivedDataWithRootObject:productModel.colors];
        sqlite3_bind_blob(statement, 6, [colorsData bytes], [colorsData length], NULL);
        
        NSData *storesData = [NSKeyedArchiver archivedDataWithRootObject:productModel.stores];
        sqlite3_bind_blob(statement, 7, [storesData bytes], [storesData length], NULL);
        
        sqlite3_bind_text(statement, 8, [productModel.uniqueId UTF8String], -1, NULL);
    }
    else {
        NSLog(@"update prepare error");
    }
    
    // Execute the statement.
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSLog(@"update error");
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(_database);
}

- (void)deleteProduct:(ProductModel*)productModel {
    NSString *query = @"DELETE from productTable WHERE uniqueId = ?";
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self getDocumentPath] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [productModel.uniqueId UTF8String], -1, NULL);
    }
    else {
        NSLog(@"delete prepare error");
    }
    
    // Execute the statement.
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSLog(@"delete error");
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(_database);
}


@end
