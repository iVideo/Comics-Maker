//
//  OCImagemSingleton.m
//  Comics Maker
//
//  Created by Rodrigo Soldi Lopes on 07/03/14.
//  Copyright (c) 2014 Rodrigo Soldi Lopes. All rights reserved.
//

#import "OCImagemSingleton.h"

@implementation OCImagemSingleton
@synthesize tirinhasProntas;

+(id)instancia{
    static OCImagemSingleton *instance = nil;
    if (!instance) {
        instance = [[super allocWithZone:nil] init];
    }
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self instancia];
}

-(void)addTirinhasProntas:(UIImage *)tirinhaPronta{
    if (!tirinhasProntas) {
        tirinhasProntas = [[NSMutableArray alloc]init];
    }
    [tirinhasProntas addObject:tirinhaPronta];
}
@end
