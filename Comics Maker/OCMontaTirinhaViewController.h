//
//  OCMontaTirinhaViewController.h
//  Comics Maker
//
//  Created by Rodrigo Soldi Lopes on 27/03/14.
//  Copyright (c) 2014 Rodrigo Soldi Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"

@interface OCMontaTirinhaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *quadro1;
@property (weak, nonatomic) IBOutlet UIImageView *quadro2;
@property (weak, nonatomic) IBOutlet UIImageView *quadro3;
@property (weak, nonatomic) IBOutlet UIButton *botaoQuadro1;
@property (weak, nonatomic) IBOutlet UIButton *botaoQuadro2;
@property (weak, nonatomic) IBOutlet UIButton *botaoQuadro3;
@property OCTirinhasSingleton *single;
@property OCTirinha *tirinhaEdicao;

-(void)recebeTirinha: (OCTirinha *)tirinha;
@end
