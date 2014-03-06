//
//  OCQuadro.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import "OCQuadro.h"

@implementation OCQuadro

- (id)initWithImagem:(UIImage *)imagem andBaloesDeTexto:(NSMutableArray *)baloesDeTexto {
    self = [super init];
    if (self) {
        _imagem = imagem;
        _baloesDeTexto = baloesDeTexto;
    }
    return self;
}

@end
