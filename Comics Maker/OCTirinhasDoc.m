//
//  OCTirinhasDoc.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import "OCTirinhasDoc.h"
#import "OCTirinhasData.h"
#import "OCTirinhasDatabase.h"

#define kDataKey        @"Data"
#define kDataFile       @"data.plist"
#define kFullImageFile  @"fullImage.png"

@implementation OCTirinhasDoc
@synthesize docPath = _docPath;
@synthesize data = _data;

@synthesize fullImage = _fullImage;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        _docPath = [docPath copy];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage {
    if ((self = [super init])) {
        _data = [[OCTirinhasData alloc] initWithTitle:title rating:rating];
        
    }
    return self;
}

- (void)dealloc {
//    _data = nil;
//    _fullImage = nil;
//    _thumbImage = nil;
    _docPath = nil;
}

- (BOOL)createDataPath {
    
    if (_docPath == nil) {
        self.docPath = [OCTirinhasDatabase nextTirinhasDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}

- (OCTirinhasData *)data{
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];//*
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey];//*
    [unarchiver finishDecoding];
    
    return _data;
    
}

- (void)saveData {
    
    //if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:[self data] forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}


- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}






@end
