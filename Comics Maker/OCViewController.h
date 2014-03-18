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
#import "OCTableViewController.h"
#import "GPUImage.h"

@interface OCViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, NSCoding>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIButton *concluido;
@property (weak, nonatomic) IBOutlet UIImageView *currentImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *proximo;
@property OCTirinhasSingleton *single;
@property (weak, nonatomic) IBOutlet UIButton *selecionar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gesture;


@end
