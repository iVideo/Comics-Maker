//
//  OCBaloesDeTexto.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCBaloesDeTexto.h"
#import <math.h>

@interface OCBaloesDeTexto ()

@end

@implementation OCBaloesDeTexto


- (id)initWithText:(NSString *)texto {
    self = [super init];
    if (self) {
        _texto = texto;
    }
    return self;
}

- (id)initWithText:(NSString *)texto andPosition:(CGPoint)inicio andOrigin:(CGPoint)origem {
    self = [super init];
    if (self) {
        _texto = texto;
        _inicio = inicio;
        _origem = origem;
    }
    
    return self;
}

- (UIImage *)balaoDesenhado {
    UIImage *balaoCompleto;
    
    return balaoCompleto;
}

- (NSUInteger)width {
    int width = _texto.length < 50 ? _texto.length * 10 : 400;
    return width > 200 ? width : 200;
}

- (NSUInteger)height {
    int height = (_texto.length / 50 + 1) * 50;
    return height > 100 ? height : 100;
}

- (CGPoint)center {
    // pensando no iPhone, multiplica-se
    // x e y por 2
    return CGPointMake(_inicio.x * 2 + _width / 2, _inicio.y * 2 + _height / 2);
}

- (float)deltaX {
    //NSLog(@"\nDelta x: %d\nDelta y: %d", self.deltaX, self.deltaY);
    return self.origem.x * 2 - self.center.x;
}

- (float)deltaY {
    return self.origem.y * 2 - self.center.y;
}

- (CGPoint)originBegin {
    // PRECISO CONSERTAR O CASO "SUDOESTE" E "NOROESTE"!!!
    
    int x, y;
    x = y = 0;
    
    if (self.center.x + (abs(self.deltaY * 0.15) > abs(self.width * 0.15))) {
        x = self.width / 15;
    } else {
        x = self.deltaY * 15;
    }
    
    if (self.center.y - (abs(self.deltaX * 0.15) > abs(self.height * 0.15))) {
        y = self.height * 0.15;
    } else {
        y = self.deltaX * 0.15;
    }
    
    if (self.deltaY < 0) {
        x = - x;
    }
    if (self.deltaX < 0) {
        y = - y;
    }
    
    
    return CGPointMake(self.center.x + x,
                       self.center.y - y);
}

- (CGPoint)originEnd {
    int x, y;
    x = y = 0;
    
    if (self.center.x - (abs(self.deltaY * 0.15) > abs(self.width * 0.15))) {
        x = self.width * 0.15;
    } else {
        x = self.deltaY * 0.15;
    }
    
    if (self.center.y + (abs(self.deltaX * 0.15) > abs(self.height * 0.15))) {
        y = self.height * 0.15;
    } else {
        y = self.deltaX * 0.15;
    }
    
    if (self.deltaY < 0) {
        x = -x;
    }
    if (self.deltaX < 0) {
        y = - y;
    }
    
    
    return CGPointMake(self.center.x - x,
                       self.center.y + y);
}






@end
