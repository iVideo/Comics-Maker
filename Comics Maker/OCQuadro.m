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
    
    // getting context from image and drawing the image on it
    CGSize newSize = CGSizeMake(imagem.size.height, imagem.size.width);
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, imagem.size.width, imagem.size.height);
    [imagem drawInRect:rect];
    
    // calculating the bubble speech width and height
    _texto = @"A";
    int width = _texto.length * 20;
    int height = (_texto.length / 20 + 10) * 20;
    width = (width > 400) ? width : 400;
    height = (height > 200) ? height : 200;
    
    // including the text in the bubble
    UIFont *font = [UIFont fontWithName:@"Arial" size:4.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     font, NSFontAttributeName,
                                     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,
                                     nil];
    
    // drawing the bubble speech
    UIImage *balaoDeTexto = [UIImage imageNamed:@"retangulo.png"];
    [balaoDeTexto drawInRect:CGRectMake(50, 50, width, height)];
    
    // writing the text
    [_texto drawInRect:CGRectIntegral(rect) withAttributes:attrsDictionary];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
    
    //return imagem;
}

@end
