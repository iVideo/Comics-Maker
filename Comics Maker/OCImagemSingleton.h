//
//  OCImagemSingleton.h
//  Comics Maker
//
//  Created by Rodrigo Soldi Lopes on 07/03/14.
//  Copyright (c) 2014 Rodrigo Soldi Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCImagemSingleton : NSObject
@property NSMutableArray *tirinhasProntas;
+(id)instancia;
-(void)addTirinhasProntas:(UIImage *)tirinhaPronta;
@end
