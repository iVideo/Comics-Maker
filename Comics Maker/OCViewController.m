//
//  OCViewController.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"
#import "OCTirinhaViewController.h"



@interface OCViewController ()
@property NSInteger contador;
@end

@implementation OCViewController
@synthesize single;
@synthesize texto;

-(void)viewDidAppear:(BOOL)animated{
    [[self navigationItem] setHidesBackButton:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    single = [OCTirinhasSingleton sharedTirinhas];
    [_proximo setEnabled:NO];
    if (single.quadroAtual==0) {
        OCTirinha *tirinha = [[OCTirinha alloc]init];
        [single addTirinha:tirinha];
    }
    single.quadroAtual++;
}

- (IBAction)cameraButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)pesquisaFotoButton:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    GPUImageSmoothToonFilter *filter = [[GPUImageSmoothToonFilter alloc] init];
    filter.threshold = 0.1;
    
    UIImage *filteredImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    filteredImage = [[[GPUImageHighlightShadowFilter alloc] init] imageByFilteringImage:filteredImage];
    filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
    filteredImage = [[[GPUImageGrayscaleFilter alloc] init] imageByFilteringImage:filteredImage];
    filteredImage = [filter imageByFilteringImage:filteredImage];
    
    //filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
    //filteredImage = [[[GPUImageSmoothToonFilter alloc] init] imageByFilteringImage:filteredImage];
    
    [_currentImage setImage:filteredImage];
    
    OCQuadro *quadro = [[OCQuadro alloc]init];
    [quadro addImagem:_currentImage.image andTexto:nil];
    OCTirinha *t = [[single tirinhas] lastObject];
    [t adicionaQuadroNoArrayDeQuadros:quadro];
    
    [_proximo setEnabled:YES];
    if (single.quadroAtual>=3) {
        [single setQuadroAtual:0];
        [self.concluido setHidden:NO];
        [self.proximo setEnabled:NO];
    }
    else{
        [self.concluido setHidden:YES];
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [texto resignFirstResponder];
    return YES;
}
@end
