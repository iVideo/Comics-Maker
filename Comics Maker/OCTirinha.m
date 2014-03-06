//
//  OCTirinha.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import "OCTirinha.h"

@implementation OCTirinha

- (id)initWithQuadros:(NSMutableArray *)quadros {
    self = [super init];
    if (self) {
        _quadros = [[NSMutableArray alloc] init];
        _quadros = quadros;
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _quadros = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)replaceQuadroAtIndex:(NSUInteger)indice withQuadro:(OCQuadro *)quadro {
    [_quadros replaceObjectAtIndex:indice withObject:quadro];
}

- (void)setImage:(UIImage *)imagem forQuadroAtIndex:(NSUInteger)indice {
    OCQuadro *quadro = [_quadros objectAtIndex:indice];
    if (quadro) {
        quadro.imagem = imagem;
    }
    if (!quadro && indice == 0) {
        quadro = [[OCQuadro alloc] init];
        quadro.imagem = imagem;
        [_quadros addObject:quadro];
    }
}

@end
