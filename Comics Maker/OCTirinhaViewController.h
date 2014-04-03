//
//  OCTirinhaViewController.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/6/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTirinha.h"


@interface OCTirinhaViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate, UITextFieldDelegate,UIAlertViewDelegate, UIActionSheetDelegate, NSCoding>

@property (weak, nonatomic) IBOutlet UIImageView *join;
@property(nonatomic)CGContextRef ctx;
@property(strong, nonatomic) OCTirinha* tirinha;
@property (weak, nonatomic) IBOutlet UIButton *botaoConcluido;
@property (weak, nonatomic) IBOutlet UIButton *editar;

- (IBAction)editar:(id)sender;

@end
