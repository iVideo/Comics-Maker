//
//  OCTirinha.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCQuadro.h"
#import "OCTirinhasSingleton.h"

@interface OCTirinha : NSObject

@property (strong, nonatomic) NSMutableArray *quadros;
@property (strong, nonatomic) UIImage *tirinhaCompleta;
@property (strong,nonatomic) NSString *titulo;
@property NSString *autor;
@property OCQuadro *quadro;
@property OCTirinhasSingleton *single;


- (id)initWithQuadros:(NSMutableArray *)quadros;
- (void)replaceQuadroAtIndex:(NSUInteger)indice withQuadro:(OCQuadro *)quadro;
- (void)setImage:(UIImage *)imagem forQuadroAtIndex:(NSUInteger)indice;
-(void)adicionaQuadroNoArrayDeQuadros: (OCQuadro *)quadro;
- (UIImage *)tirinhaCompleta;

@end
