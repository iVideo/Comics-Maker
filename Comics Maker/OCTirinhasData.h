//
//  OCTirinhasData.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTirinhasData : NSObject <NSCoding>{
    NSString *_title;
    float _rating;
    NSString *_docPath;

}

@property  float rating;
@property (copy) NSString *title;
@property (copy) NSString *docPath;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
- (id)initWithTitle:(NSString*)title rating:(float)rating;

@end
