//
//  OCViewController.h
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"
#import "OCQuadro.h"

@interface OCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *currentImage;
@property (weak, nonatomic) IBOutlet UITextField *texto;

@end
