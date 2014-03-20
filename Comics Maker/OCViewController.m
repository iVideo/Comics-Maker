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
    _switchInserirBalao = 0;
    [_botaoInserirBalao setHidden:YES];
    
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
    [_textoBalao setHidden:NO];
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
    _texto = _textoBalao.text;
    [textField resignFirstResponder];
    [_botaoInserirBalao setHidden:NO];
    [_textoBalao setHidden:YES];
    return YES;
}


//Pegando tap para inserir os baloes
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    
    if (_switchInserirBalao == 1) {
        CGPoint tapPoint = [sender locationInView:_currentImage];
        int tapX = (int) tapPoint.x * 2;
        int tapY = (int) tapPoint.y * 2;
        OCBaloesDeTexto *balao = [[OCBaloesDeTexto alloc] initWithText:_texto andPosition:CGPointMake(tapX, tapY) andOrigin:CGPointMake(tapX, tapY)];
        _currentImage.image = [single imageByInsertingBalao:balao atIndex:(single.tirinhas.count - 1) andQuadro:(single.quadroAtual == 0 ? 2 : single.quadroAtual - 1)];
        [single salvarImagemNoDisco:_currentImage.image];
        [_botaoInserirBalao setTitle:@"Inserir origem" forState:UIControlStateNormal];
    }
    else if (_switchInserirBalao == 2) {
        CGPoint tapPoint = [sender locationInView:_currentImage];
        int tapX = (int) tapPoint.x * 2;
        int tapY = (int) tapPoint.y * 2;
        OCBaloesDeTexto *balao = [[OCBaloesDeTexto alloc] initWithText:@"Texto está aqui" andPosition:CGPointMake(tapX, tapY) andOrigin:CGPointMake(tapX, tapY)];
        _currentImage.image = [single imageByInsertingOrigemAtPoint:CGPointMake(tapX, tapY) forBalao:balao atIndex:(single.tirinhas.count - 1) andQuadro:(single.quadroAtual == 0 ? 2 : single.quadroAtual - 1)];
        [single salvarImagemNoDisco:_currentImage.image];
        [_botaoInserirBalao setTitle:@"" forState:UIControlStateNormal];
    }

}

- (IBAction)inserirBalao:(id)sender {
    if (_switchInserirBalao == 0) {
        _switchInserirBalao = 1;
    } else if (_switchInserirBalao == 1){
        _switchInserirBalao = 2;
    } else {
        _switchInserirBalao = 0;
    }
}
- (IBAction)cancelar:(id)sender {
    [[single tirinhas] removeLastObject];
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
    [self.navigationController pushViewController:table animated:YES];
}

@end
