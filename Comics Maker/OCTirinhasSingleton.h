//
//  OCTirinhasSingleton.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage.h>
#import "OCBaloesDeTexto.h"


@interface OCTirinhasSingleton : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *tirinhas;
@property (nonatomic) NSInteger quadroAtual;
@property (strong, nonatomic) OCBaloesDeTexto *balaoAtual;
@property (strong, nonatomic) NSIndexPath *linhaDaTabela;
@property (nonatomic) BOOL novaTirinha;

+ (id)sharedTirinhas;
- (void)addTirinha:(NSObject *)tirinha;
- (void)removeTirinhaAtIndex:(NSUInteger)indice;
- (void)salvarImagemNoDisco:(UIImage *)imagem;
-(UIImage *)renderizarImagem : (UIImage *)imagem;
- (UIImage *)imageByInsertingOrigemAtPoint:(CGPoint)point forBalao:(OCBaloesDeTexto *)balao atIndex:(NSUInteger)index andQuadro:(NSUInteger)quadro;
- (UIImage *)imageByInsertingBalao:(OCBaloesDeTexto *)balao atIndex:(NSUInteger)index andQuadro:(NSUInteger)quadro;
-(void)compartilharNoFacebook: (NSInteger)indice;
@end
