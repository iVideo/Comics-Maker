//
//  OCTirinhasSingleton.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage.h>


@interface OCTirinhasSingleton : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *tirinhas;
@property (nonatomic) NSInteger quadroAtual;
+ (id)sharedTirinhas;
- (void)addTirinha:(NSObject *)tirinha;
- (void)removeTirinhaAtIndex:(NSUInteger)indice;
-(UIImage *)renderizarImagem : (UIImage *)imagem;
-(void)compartilharNoFacebook: (NSInteger)indice;
@end
