//
//  OCViewController.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"
#import "OCTirinhaViewController.h"
#import "OCMontaTirinhaViewController.h"



@interface OCViewController ()
@property NSInteger contador;
@property OCBaloesDeTexto *balaoSelecionado;
@property BOOL movendoBalao;
@property CGPoint novaOrigem;
@end

@implementation OCViewController
@synthesize single;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_textoBalao setDelegate:self];
    _textoBalao.placeholder = @"Digite um texto para o balão";
    
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
        OCTirinha *tirinha = [[OCTirinha alloc] init];
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

- (BOOL)point:(CGPoint)local isOverBalao:(OCBaloesDeTexto *)b {
    if (local.x >= b.inicio.x && local.x <= b.inicio.x + b.width &&
        local.y >= b.inicio.y && local.y <= b.inicio.y + b.height) {
        return YES;
    }
    return NO;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [_selecionar setHidden:YES];
    [_textoBalao setHidden:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [_currentImage setImage:[single renderizarImagem:[info objectForKey:@"UIImagePickerControllerEditedImage"]]];
    [_proximo setEnabled:YES];
//    if (single.quadroAtual>=3) {
//        [single setQuadroAtual:0];
//        [self.concluido setHidden:NO];
//        [self.proximo setEnabled:NO];
//        [[self navigationItem] setTitle:@""];
//    }
//    else{
//        [self.concluido setHidden:YES];
//    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _texto = _textoBalao.text;
    [textField resignFirstResponder];
    [_botaoInserirBalao setHidden:NO];
    return YES;
}


//Pegando tap para inserir os baloes
- (IBAction)tap:(UITapGestureRecognizer *)sender {

    CGPoint tapPoint = [sender locationInView:_currentImage];
    
    if (tapPoint.y < 0 || tapPoint.y > 300) {
        return;
    }
    
    BOOL acrescentar = YES;
    OCTirinha *t = [single.tirinhas lastObject];
    OCQuadro *q = t.quadros[single.quadroAtual - 1];
    OCBaloesDeTexto *b = [[OCBaloesDeTexto alloc] initWithText:_texto andPosition:CGPointMake(tapPoint.x, tapPoint.y) andOrigin:CGPointMake(tapPoint.x, tapPoint.y)];
    for (OCBaloesDeTexto *bl in q.baloes) {
        if ([self point:tapPoint isOverBalao:bl]) {
            [q.baloes removeObject:bl];
            acrescentar = NO;
            break;
        }
    }
    if (acrescentar) {
        [q.baloes addObject:b];
    }
    
    _currentImage.image = q.imagem;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint local = [touch locationInView:_currentImage];
    
    OCTirinha *t = [single.tirinhas lastObject];
    OCQuadro *q = t.quadros[single.quadroAtual - 1];
    _movendoBalao = NO;
    for (OCBaloesDeTexto *b in q.baloes) {
        if ([self point:local isOverBalao:b]) {
            _balaoSelecionado = b;
            _movendoBalao = YES;
        }
    }
    
    _novaOrigem = local;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    OCTirinha *t = [single.tirinhas lastObject];
    OCQuadro *q = t.quadros[single.quadroAtual - 1];
    
    if (_movendoBalao) {
        UITouch *t = [touches anyObject];
        CGPoint location = [t locationInView:_currentImage];
        
        _balaoSelecionado.inicio = location;
        _currentImage.image = q.imagem;
        
        [_currentImage setNeedsDisplay];

    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint l = [touch locationInView:_currentImage];
    
    OCTirinha *t = [single.tirinhas lastObject];
    OCQuadro *q = t.quadros[single.quadroAtual - 1];
    
    if (!_movendoBalao) {
        for (OCBaloesDeTexto *b in q.baloes) {
            if ([self point:l isOverBalao:b]) {
                b.origem = l;
            }
        }
    }
    
    [_currentImage setNeedsDisplay];
}

- (IBAction)inserirBalao:(id)sender {
    if (_switchInserirBalao == 0) {
        _switchInserirBalao = 1;
        [_botaoInserirBalao setTitle:@"Inserir Origem" forState:UIControlStateNormal];
    } else {
        _switchInserirBalao = 0;
        [_botaoInserirBalao setTitle:@"Inserir Balões" forState:UIControlStateNormal];
    }
    NSLog(@"%d", _switchInserirBalao);
}

- (IBAction)cancelar:(id)sender {
//    [[single tirinhas] removeLastObject];
//    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
//    [self.navigationController pushViewController:table animated:YES];
}

@end
