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

- (void)viewDidLoad
{
    [super viewDidLoad];
    single = [OCTirinhasSingleton sharedTirinhas];
    [_proximo setEnabled:NO];
    if (single.quadroAtual==0) {
        OCTirinha *tirinha = [[OCTirinha alloc]init];
        [single addTirinha:tirinha];
        [[self navigationItem] setHidesBackButton:YES];

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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_currentImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
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
- (IBAction)finalizar:(id)sender {
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaViewController"];
    [self.navigationController setViewControllers:[[NSArray alloc] initWithObjects:table,nil]animated:YES];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"passou por aqui");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [texto resignFirstResponder];
    return YES;
}
@end
