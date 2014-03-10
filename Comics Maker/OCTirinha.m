//
//  OCTirinha.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCTirinha.h"
#import "OCTirinhasSingleton.h"
#import "OCQuadro.h"

@implementation OCTirinha
@synthesize quadros;

- (id)initWithQuadros:(NSMutableArray *)q {
    self = [super init];
    if (self)
        quadros = [[NSMutableArray alloc] initWithArray:q];
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        quadros = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)replaceQuadroAtIndex:(NSUInteger)indice withQuadro:(OCQuadro *)quadro {
    [quadros replaceObjectAtIndex:indice withObject:quadro];
}

- (void)setImage:(UIImage *)imagem forQuadroAtIndex:(NSUInteger)indice {
    OCQuadro *quadro = [quadros objectAtIndex:indice];
    if (quadro) {
        quadro.imagem = imagem;
    }
    if (!quadro && indice == 0) {
        quadro = [[OCQuadro alloc] init];
        quadro.imagem = imagem;
        [quadros addObject:quadro];
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
    
    
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSetLineWidth(ctx, 50);
    //
    //    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    //    CGColorRef color = CGColorCreate(colorspace, components);
    //    CGContextSetStrokeColorWithColor(ctx, color);
    //
    //    CGContextStrokePath(ctx);
    
    UIImage *tirinhaCompleta;
    
    OCQuadro* quad = quadros[0];
    UIImage* first = quad.imagem;
                      
    quad = quadros[1];
    UIImage* second = quad.imagem;
    
    quad = quadros[2];
    UIImage* third = quad.imagem;
    
    
    CGSize newSize = CGSizeMake(209, 260); //size of image view
    UIGraphicsBeginImageContext( newSize );
    
    // drawing 1st image
    [first drawInRect:CGRectMake(0,0,newSize.width/2,newSize.height/2)];
    
    // drawing the 2nd image after the 1st
    [second drawInRect:CGRectMake(0,newSize.height/2,newSize.width/2,newSize.height/2)] ;
    
    tirinhaCompleta = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return tirinhaCompleta;
}

@end
