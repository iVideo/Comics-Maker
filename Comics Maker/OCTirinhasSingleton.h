//
//  OCTirinhasSingleton.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCTirinhasDoc.h"

@interface OCTirinhasSingleton : NSObject{
    OCTirinhasDoc *_bugDoc;

}

@property (strong, nonatomic) NSMutableArray *tirinhas;
@property (nonatomic) NSInteger quadroAtual;
@property (retain) OCTirinhasDoc* _bugDoc;
+ (id)sharedTirinhas;
- (void)addTirinha:(NSObject *)tirinha;
- (void)removeTirinhaAtIndex:(NSUInteger)indice;

@end
