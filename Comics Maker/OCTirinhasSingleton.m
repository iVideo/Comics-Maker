//
//  OCTirinhasSingleton.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"

@implementation OCTirinhasSingleton

+ (id)sharedTirinhas {
    static OCTirinhasSingleton *instance = nil;
    
    if (!instance) {
        instance = [[super allocWithZone:nil] init];
    }
    return instance;
}

- (id)init {
    self.tirinhas = [[NSMutableArray alloc] init];
    return self;
}

- (void)addTirinha:(NSObject *)tirinha {
    [_tirinhas addObject:tirinha];
}

- (void)removeTirinhaAtIndex:(NSUInteger)indice {
    [_tirinhas removeObjectAtIndex:indice];
}

@end
