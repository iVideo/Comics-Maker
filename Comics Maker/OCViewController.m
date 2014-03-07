//
//  OCViewController.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"
#import "OCTirinhaViewController.h"
#import "OCTirinhasSingleton.h"

@interface OCViewController ()
@property NSInteger contador;
@end

@implementation OCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    OCTirinhasSingleton *single = [OCTirinhasSingleton sharedTirinhas];
    single.quadroAtual++;
    NSLog(@"did load");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_currentImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    OCTirinhasSingleton *tirinhasSingleton = [OCTirinhasSingleton sharedTirinhas];
    OCTirinha *novaTirinha = [tirinhasSingleton.tirinhas lastObject];
    NSLog(@"%d",tirinhasSingleton.quadroAtual);
    [novaTirinha setImage:_currentImage.image forQuadroAtIndex:tirinhasSingleton.quadroAtual];
    
    if (tirinhasSingleton.quadroAtual==3) {
        [self.concluido setHidden:NO];
        [self.proximo setEnabled:NO];
    }
    else{
        [self.concluido setHidden:YES];
    }
}
@end
