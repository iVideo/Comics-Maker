//
//  OCMontaTirinhaViewController.m
//  Comics Maker
//
//  Created by Rodrigo Soldi Lopes on 27/03/14.
//  Copyright (c) 2014 Rodrigo Soldi Lopes. All rights reserved.
//

#import "OCMontaTirinhaViewController.h"
#import "OCViewController.h"
#import "OCTableViewController.h"
#import "OCQuadro.h"


@interface OCMontaTirinhaViewController ()

@end

@implementation OCMontaTirinhaViewController
@synthesize single;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self navigationItem] leftBarButtonItem] setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setHidden:NO];
    
    
    single = [OCTirinhasSingleton sharedTirinhas];

    if (single.novaTirinha) {
        OCTirinha *tirinha = [[OCTirinha alloc]init];
        [single addTirinha:tirinha];
        OCQuadro *quadro = [[OCQuadro alloc]initWithTexto:nil];
        [quadro setImagem:[UIImage imageNamed:@"placeholder"]];

        [[[[single tirinhas] lastObject] quadros] insertObject:quadro atIndex:0];
        [[[[single tirinhas] lastObject] quadros] insertObject:quadro atIndex:1];
        [[[[single tirinhas] lastObject] quadros] insertObject:quadro atIndex:2];
        [single setNovaTirinha:NO];
    }

    [self insereImagemNosQuadros];
    if (self.tirinhaEdicao) {
        [self insereTirinhaProntaParaEdicao];
    }
}


- (IBAction)botaoQuadro1:(id)sender {
    [single setQuadroAtual:0];
}
- (IBAction)botaoQuadro2:(id)sender {
    [single setQuadroAtual:1];
}
- (IBAction)botaoQuadro3:(id)sender {
    [single setQuadroAtual:2];
}

-(void)recebeTirinha: (OCTirinha *)tirinha{
    self.tirinhaEdicao = tirinha;
}

-(void)insereTirinhaProntaParaEdicao{
    [_quadro1 setImage:[[[[self tirinhaEdicao] quadros] objectAtIndex:0] imagem]];
    [_quadro2 setImage:[[[[self tirinhaEdicao] quadros] objectAtIndex:1] imagem]];
    [_quadro3 setImage:[[[[self tirinhaEdicao] quadros] objectAtIndex:2] imagem]];
}

-(void)insereImagemNosQuadros{
    if (![single novaTirinha]) {
        [_quadro1 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:0] imagem]];
        [_quadro2 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:1] imagem]];
        [_quadro3 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:2] imagem]];
    }
}

- (IBAction)cancelar:(id)sender {
    if (!single.editandoTirinha) {
        [[single tirinhas] removeLastObject];
    }
    
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
    [self.navigationController pushViewController:table animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [single setEditandoTirinha:NO];
    OCViewController *destViewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"quadro1"]) {
        [destViewController recebeImagem:_quadro1.image];
    }
    else if ([segue.identifier isEqualToString:@"quadro2"]){
        [destViewController recebeImagem:_quadro2.image];
    }
    else if ([segue.identifier isEqualToString:@"quadro3"]) {
        [destViewController recebeImagem:_quadro3.image];
    }

    
}

@end
