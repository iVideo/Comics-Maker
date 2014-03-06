//
//  OCTirinha.h
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCQuadro.h"

@interface OCTirinha : NSObject

@property (strong, nonatomic) NSMutableArray *quadros;

- (id)initWithQuadros:(NSMutableArray *)quadros;
- (void)replaceQuadroAtIndex:(NSUInteger)indice withQuadro:(OCQuadro *)quadro;
- (void)setImage:(UIImage *)imagem forQuadroAtIndex:(NSUInteger)indice;

@end
