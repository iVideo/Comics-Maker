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

- (UIImage *)balaoDesenhado {
    UIImage *balaoCompleto;
    
    return balaoCompleto;
}

- (NSUInteger)width {
    int width = _texto.length < 50 ? _texto.length * 10 : 400;
    return width > 200 ? width : 200;
}

- (NSUInteger)height {
    int height = (_texto.length / 50 + 1) * 50;
    return height > 100 ? height : 100;
}



@end
