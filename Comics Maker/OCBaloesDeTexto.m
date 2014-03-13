//
//  OCBaloesDeTexto.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCBaloesDeTexto.h"

@implementation OCBaloesDeTexto

- (id)initWithText:(NSString *)texto {
    self = [super init];
    if (self) {
        _texto = texto;
    }
    return self;
}

- (id)initWithText:(NSString *)texto andPosition:(CGPoint)inicio andOrigin:(CGPoint)origem {
    self = [super init];
    if (self) {
        _texto = texto;
        _inicio = inicio;
        _origem = origem;
    }
    
    return self;
}



@end
