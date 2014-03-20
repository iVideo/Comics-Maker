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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _texto = [decoder decodeObjectForKey:@"texto"];
        _key = [decoder decodeObjectForKey:@"key"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_texto forKey:@"texto"];
    [encoder encodeObject:_key forKey:@"key"];
}
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
    return loadedImage;
}

- (UIImage *)drawBaloesDeTexto:(UIImage *)imagem {
    
    if (!self.temFalas) {
        return imagem;
    }
    
    // getting context from image and drawing the image on it
    CGSize newSize = CGSizeMake(imagem.size.height, imagem.size.width);
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, imagem.size.width, imagem.size.height);
    [imagem drawInRect:rect];
    
    NSLog(@"entrou no for pra escrever o texto");
    // calculating the bubble speech width and height
    _texto = @"Aqui vai o texto!";
    int width = _texto.length * 20;
    int height = (_texto.length / 20 + 10) * 20;
    width = (width > 400) ? width : 400;
    height = (height > 200) ? height : 200;
    
    // including the text in the bubble
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    font, NSFontAttributeName,
                                    [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,
                                    nil];
    
    // drawing the bubble speech
    UIImage *balaoDeTexto = [UIImage imageNamed:@"retangulo.png"];
    [balaoDeTexto drawInRect:CGRectMake(50, 50, width, height)];
        
    // writing the text
    [_texto drawInRect:CGRectIntegral(CGRectMake(50, 50, width, height)) withAttributes:attrsDictionary];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return img;
    
    //return imagem;
}

- (void)addBalaoComTexto:(NSString *)texto noPonto:(CGPoint)ponto {
    OCBaloesDeTexto *b = [[OCBaloesDeTexto alloc] initWithText:texto andPosition:ponto andOrigin:ponto];
    [_baloes addObject:b];
}

@end
