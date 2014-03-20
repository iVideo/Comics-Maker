//
//  OCViewController.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"
#import "OCTirinhaViewController.h"



@interface OCViewController ()
@property NSInteger contador;
@end

@implementation OCViewController
@synthesize single;

-(void)viewDidAppear:(BOOL)animated{
//    if (single.quadroAtual==1) {
//        [[self navigationItem] setHidesBackButton:NO];
//    }else{
//        [[self navigationItem] setHidesBackButton:YES];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_textoBalao setDelegate:self];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setHidden:NO];
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [tap setDelegate:self];
    [[self currentImage] addGestureRecognizer:tap];
    
    single = [OCTirinhasSingleton sharedTirinhas];
    [_proximo setEnabled:NO];
    if (single.quadroAtual==0) {
        OCTirinha *tirinha = [[OCTirinha alloc]init];
        [single addTirinha:tirinha];
    }
    single.quadroAtual++;
}

-(BOOL)shouldAutorotate{
    return NO;
}


- (IBAction)selecionar:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Tipo de Imagem:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto",@"Escolher da Biblioteca", nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setAllowsEditing:YES];
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:picker animated:YES completion:nil];
                    break;
                case 1:
                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:picker animated:YES completion:nil];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [_selecionar setHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [_currentImage setImage:[single renderizarImagem:[info objectForKey:@"UIImagePickerControllerEditedImage"]]];
    [_proximo setEnabled:YES];
    if (single.quadroAtual>=3) {
        [single setQuadroAtual:0];
        [self.concluido setHidden:NO];
        [self.proximo setEnabled:NO];
        [[self navigationItem] setTitle:@""];
    }
    else{
        [self.concluido setHidden:YES];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


//Pegando tap para inserir os baloes
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:_currentImage];
    int tapX = (int) tapPoint.x;
    int tapY = (int) tapPoint.y;
    
    NSLog(@"X: %d     Y: %d",tapX,tapY);
}
- (IBAction)inserirBalao:(id)sender {

}
- (IBAction)cancelar:(id)sender {
    [[single tirinhas] removeLastObject];
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
    [self.navigationController pushViewController:table animated:YES];
}

@end
