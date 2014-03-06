//
//  OCTirinhasSingleton.h
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTirinhasSingleton : NSObject

@property (strong, nonatomic) NSMutableArray *tirinhas;

+ (id)sharedTirinhas;
- (void)addTirinha:(NSObject *)tirinha;
- (void)removeTirinhaAtIndex:(NSUInteger)indice;

@end
