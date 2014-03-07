//
//  OCViewController.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"
#import "OCTirinhaViewController.h"
#import "OCQuadro.h"

@interface OCViewController ()
@property NSInteger contador;
@end

@implementation OCViewController
@synthesize single;

- (void)viewDidLoad
{
    [super viewDidLoad];
    single = [OCTirinhasSingleton sharedTirinhas];
    single.quadroAtual++;
    [_proximo setEnabled:NO];
}

- (IBAction)cameraButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)pesquisaFotoButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_currentImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    OCQuadro *quadro = [[OCQuadro alloc]init];
    [quadro addImagem:_currentImage.image andTexto:nil];
    
    [_proximo setEnabled:YES];
    if (single.quadroAtual==3) {
        [self.concluido setHidden:NO];
        [self.proximo setEnabled:NO];
    }
    else{
        [self.concluido setHidden:YES];
    }
}
@end
