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

- (id)init {
    self = [super init];
    if (self) {
        _baloes = [[NSMutableArray alloc] init];
        _imagem = [[UIImage alloc] init];
    }
    return self;
}

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
    
    return [self drawBaloesDeTexto:loadedImage];
    
    //return loadedImage;
}

- (UIImage *)drawBaloesDeTexto:(UIImage *)imagem {
    
    BOOL desenhar = YES;
    int x, y;
    UIImage *newImage = imagem;

    for (OCBaloesDeTexto *b in _baloes) {
        // fix x and y
        
        if (b.inicio.x < 0 || b.inicio.x > 300 ||
            b.inicio.y < 0 || b.inicio.y > 300) {
            desenhar = NO;
        }
        else {
            desenhar = YES;
            x = b.inicio.x * 2;
            y = b.inicio.y * 2;
        }
        
        if (desenhar) {
        // setting height and width of the OCBalao
        int width = b.texto.length < 50 ? b.texto.length * 10 : 400;
        int height = (b.texto.length / 50 + 1) * 50;
        if (width < 200) width = 200;
        if (height < 100) height = 100;
        b.width = width;
        b.height = height;
        
        // log informativo
        NSLog(@"-\n%@ x: %d y: %d", b.texto, x, y);
        
        // iniciando o contexto com a imagem
        UIGraphicsBeginImageContext(imagem.size);
        [imagem drawAtPoint:CGPointZero];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // setting the colors
        [[UIColor blackColor] setStroke];
        
        // drawing the OCBalao
        CGRect balaoRect = CGRectMake(x, y,
                                      b.width,
                                      b.height);
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *atts = [NSDictionary dictionaryWithObjectsAndKeys:
                              font, NSFontAttributeName,
                              [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,
                              NSParagraphStyleAttributeName, paragraphStyle,
                              nil];
        CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextFillEllipseInRect(ctx, balaoRect);
        [b.texto drawInRect:CGRectMake(x + width * 0.2, y + height * 0.2, width * 0.6, height * 0.6) withAttributes:atts];
            
    /*
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, b.inicio.x + b.width / 2 + 30, b.inicio.y + b.height / 2);
            CGContextAddLineToPoint(ctx, b.origem.x, b.origem.y);
            CGContextAddLineToPoint(ctx, b.inicio.x + b.width / 2 - 30, b.inicio.y + b.height / 2);
            CGContextStrokePath(ctx);
      */      
        
        // getting the new image
        imagem = UIGraphicsGetImageFromCurrentImageContext();
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // free the context
        UIGraphicsEndImageContext();
        }
    }
    
    return newImage;
}

- (void)addBalaoComTexto:(NSString *)texto noPonto:(CGPoint)ponto {
    OCBaloesDeTexto *b = [[OCBaloesDeTexto alloc] initWithText:texto andPosition:ponto andOrigin:ponto];
    [_baloes addObject:b];
}

@end
