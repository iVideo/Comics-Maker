//
//  OCQuadro.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCQuadro.h"

@implementation OCQuadro

- (id)initWithImagem:(UIImage *)imagem andTexto:(NSString *)texto{
    self = [super init];
    if (self) {
        _imagem = imagem;
        _texto = texto;
//        _baloesDeTexto = baloesDeTexto;
    }
    return self;
}

@end
