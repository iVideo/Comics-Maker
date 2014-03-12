//
//  OCTirinhasDatabase.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTirinhasDatabase : NSObject

+ (NSMutableArray *)loadTirinhasDocs;
+ (NSString *)nextTirinhasDocPath;

@end
