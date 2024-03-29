//
//  OCTirinha.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCTirinhasSingleton.h"
#import "OCQuadro.h"
#import "OCTirinha.h"

@implementation OCTirinha
@synthesize quadros;
@synthesize single;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        quadros = [decoder decodeObjectForKey:@"quadros"];
        _quadro = [decoder decodeObjectForKey:@"quadro"];
        _titulo = [decoder decodeObjectForKey:@"titulo"];
        _autor = [decoder decodeObjectForKey:@"autor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:quadros forKey:@"quadros"];
    [encoder encodeObject:_quadro forKey:@"quadro"];
    [encoder encodeObject:_titulo forKey:@"titulo"];
    [encoder encodeObject:_autor forKey:@"autor"];
    
}

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
        single = [OCTirinhasSingleton sharedTirinhas];
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

-(void)adicionaQuadroNoArrayDeQuadros: (OCQuadro *)quadro noIndice:(NSInteger)indice{
    if (quadros == Nil) {
        quadros = [[NSMutableArray alloc]init];
    }
    [quadros setObject:quadro atIndexedSubscript:indice];
}

- (UIImage *)tirinhaCompleta {
    /* esse é o getter da tirinhaCompleta. Sempre que
     a gente tentar acessar a propriedade tirinhaCompleta
     a gente vai rodar esse método.
     --> ele deve (i) criar um contexto; (ii) acrescentar as 
     três imagens dos três quadros da tirinha no contexto; e
     (iii) retornar a imagem do contexto contexto.image;
     */
    
    UIImage *tirinhaCompleta;
    
    //Get the 1st image
    OCQuadro* quad = quadros[0];
    UIImage* first = quad.imagem;
    
    //get the 2nd image
    quad = quadros[1];
    UIImage* second = quad.imagem;
    
    //get the 3rd image
    quad = quadros[2];
    UIImage* third = quad.imagem;
    
    //create the area of the final image
    CGSize newSize = CGSizeMake(1152, 390);
    UIGraphicsBeginImageContext( newSize );
    
    // drawing 1st imag
    [first drawInRect:CGRectMake(10,10,(newSize.width - 40)/3,(newSize.height - 20))];
    
    // drawing the 2nd image after the 1st
    [second drawInRect:CGRectMake(newSize.width/3 + 5,10,(newSize.width - 40)/3,(newSize.height - 20))] ;

    //drawing the 3rd image after the 2nd
    [third drawInRect:CGRectMake(newSize.width*2/3,10,(newSize.width - 40)/3,(newSize.height - 20))];

    
    tirinhaCompleta = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tirinhaCompleta;
}

- (UIImage *)tirinhaPequena {
    
    if (!_tirinhaPequena) {
        _tirinhaPequena = [self imageWithImage:[self tirinhaCompleta] scaledToSize:CGSizeMake(115, 39)];
    }
    
    return _tirinhaPequena;
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
