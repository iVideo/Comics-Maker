//
//  OCQuadro.h
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCQuadro : NSObject

@property (weak, nonatomic) UIImage *imagem;
@property (weak, nonatomic) NSMutableArray *baloesDeTexto;

- (id)initWithImagem:(UIImage *)imagem andBaloesDeTexto:(NSMutableArray *)baloesDeTexto;

@end
