//
//  OCQuadro.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCQuadro.h"
#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"

@implementation OCQuadro

- (id)initWithTexto:(NSString *)texto{
    self = [super init];
    if (self) {
        _texto = texto;
        OCTirinhasSingleton *t = [OCTirinhasSingleton sharedTirinhas];
        [t addTirinha:self];
    }
    return self;
}

-(void)addTexto:(NSString *)texto andKey:(NSString *)key{
    self.texto = texto;
    self.key = key;
}

- (UIImage *)imagem {
    NSString *path = [@"/Documents/" stringByAppendingString:_key];
    path = [NSHomeDirectory() stringByAppendingString:path];
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage *loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    loadedImage = [self drawBaloesDeTexto:loadedImage];
    return loadedImage;
}

- (UIImage *)drawBaloesDeTexto:(UIImage *)imagem {
    
//    CGSize newSize = CGSizeMake(imagem.size.height, imagem.size.width);
//    UIGraphicsBeginImageContext(newSize);
//    [imagem drawInRect:CGRectMake(0, 0, imagem.size.width, imagem.size.height)];
//    UIImage *balaoDeTexto = [UIImage imageNamed:@"retangulo.png"];
//    [balaoDeTexto drawInRect:CGRectMake(50, 50, 600, 200)];
//    return UIGraphicsGetImageFromCurrentImageContext();
    
    return imagem;
}

@end
