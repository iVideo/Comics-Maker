//
//  OCTirinhasSingleton.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
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
    _tirinhas = [[NSMutableArray alloc] init];
    
    _quadroAtual = 0;
    return self;
}

- (void)addTirinha:(NSObject *)tirinha {
    [_tirinhas addObject:tirinha];
    [_bugDoc saveData];
    
}

- (void)removeTirinhaAtIndex:(NSUInteger)indice {
    [_tirinhas removeObjectAtIndex:indice];
}

@end
