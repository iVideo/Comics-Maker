//
//  OCTirinha.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
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

- (UIImage *)tirinhaCompleta {
    /* esse é o getter da tirinhaCompleta. Sempre que
     a gente tentar acessar a propriedade tirinhaCompleta
     a gente vai rodar esse método.
     --> ele deve (i) criar um contexto; (ii) acrescentar as 
     três imagens dos três quadros da tirinha no contexto; e
     (iii) retornar a imagem do contexto contexto.image;
     */
    
    UIImage *tirinhaCompleta;
    
    // your code goes here...
    
    return tirinhaCompleta;
}

@end
