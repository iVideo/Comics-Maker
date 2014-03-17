//
//  OCData.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/17/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SQLitePersistentObject.h"


@interface OCData : NSObject{
    NSString *databasePath;
}

+(OCData*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
      department:(NSString*)department year:(NSString*)year;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end
