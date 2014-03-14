//
//  OCTirinhasDoc.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCTirinhasData.h"

@interface OCTirinhasDoc : NSObject {
    OCTirinhasData *_data;
    NSString *_docPath;
}

@property (copy) NSString *docPath;
@property (retain) OCTirinhasData *data;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
//- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;
@end
