//
//  OCTirinhasDatabase.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import "OCTirinhasDatabase.h"
#import "OCTirinhasDoc.h"

@implementation OCTirinhasDatabase

+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}

+ (NSMutableArray *)loadTirinhasDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [OCTirinhasDatabase getPrivateDocsDir];
    NSLog(@"Loading comics from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create TirinhasDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"oc" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            OCTirinhasDoc *doc = [[OCTirinhasDoc alloc] initWithDocPath:fullPath];//*
            [retval addObject:doc];
        }
    }
    
    return retval;
    
}

+ (NSString *)nextTirinhasDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [OCTirinhasDatabase getPrivateDocsDir];
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Search for an available name
    int maxNumber = 0;
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"oc" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.oc", maxNumber+1];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
}
    
@end
