//
//  OCQuadro.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCQuadro : NSObject

@property (weak, nonatomic) UIImage* imagem;
@property (weak, nonatomic) NSString* texto;


//@property (weak, nonatomic) NSMutableArray *baloesDeTexto;

- (id)initWithImagem:(UIImage *)imagem andTexto:(NSString *)texto;

@end
