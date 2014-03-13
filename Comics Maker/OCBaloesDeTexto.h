//
//  OCBaloesDeTexto.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCBaloesDeTexto : NSObject

@property (strong, nonatomic) NSString *texto;
@property CGPoint inicio;
@property CGPoint origem;

- (id)initWithText:(NSString *)texto;
- (id)initWithText:(NSString *)texto andPosition:(CGPoint)inicio andOrigin:(CGPoint)origem;

@end
