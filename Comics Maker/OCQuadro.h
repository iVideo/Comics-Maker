//
//  OCQuadro.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCBaloesDeTexto.h"

@interface OCQuadro : NSObject

@property (strong, nonatomic) UIImage *imagem;
@property (strong, nonatomic) NSString *texto;
@property (strong, nonatomic) NSString *key;
@property (getter = temFalas, setter = setFalas:) BOOL falas;
@property (strong, nonatomic) NSMutableArray *baloes;


//@property (weak, nonatomic) NSMutableArray *baloesDeTexto;

- (id)initWithTexto:(NSString *)texto;
- (void)addTexto:(NSString *)texto andKey:(NSString *)key;
- (void)addBalaoComTexto:(NSString *)texto noPonto:(CGPoint)ponto;

@end
