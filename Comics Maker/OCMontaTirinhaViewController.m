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

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    static NSInteger tamanhoQuadroPortraitIpad = 250;
    static NSInteger tamanhoQuadroPortraitIphone = 100;
    static NSInteger tamanhoQuadroLandscapeIpad = 340;
    static NSInteger tamanhoQuadroLandscapeIphone = 180;
    
    static NSInteger yPortraitIpad = 380;
    static NSInteger yPortraitIphone = 244;
    static NSInteger yLandscapeIpad = 230;
    static NSInteger yLandscapeIphone = 75;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
        
        if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
            [_quadro1 setFrame: CGRectMake(0, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
            [_botaoQuadro1 setFrame: CGRectMake(0, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
            
            [_quadro2 setFrame: CGRectMake(260, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
            [_botaoQuadro2 setFrame: CGRectMake(260, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
            
            [_quadro3 setFrame: CGRectMake(520, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
            [_botaoQuadro3 setFrame: CGRectMake(520, yPortraitIpad, tamanhoQuadroPortraitIpad, tamanhoQuadroPortraitIpad)];
        }
        else{
            [_quadro1 setFrame: CGRectMake(0, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
            [_botaoQuadro1 setFrame: CGRectMake(0, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
            
            [_quadro2 setFrame: CGRectMake(345, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
            [_botaoQuadro2 setFrame: CGRectMake(345, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
            
            [_quadro3 setFrame: CGRectMake(690, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
            [_botaoQuadro3 setFrame: CGRectMake(690, yLandscapeIpad, tamanhoQuadroLandscapeIpad, tamanhoQuadroLandscapeIpad)];
        }
    } else {
        
        if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
            [_quadro1 setFrame: CGRectMake(0, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            [_botaoQuadro1 setFrame: CGRectMake(0, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            
            [_quadro2 setFrame: CGRectMake(110, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            [_botaoQuadro2 setFrame: CGRectMake(110, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            
            [_quadro3 setFrame: CGRectMake(218, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            [_botaoQuadro3 setFrame: CGRectMake(218, yPortraitIphone, tamanhoQuadroPortraitIphone, tamanhoQuadroPortraitIphone)];
            
        }
        else{
            [_quadro1 setFrame: CGRectMake(5, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
            [_botaoQuadro1 setFrame: CGRectMake(5, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
            
            [_quadro2 setFrame: CGRectMake(195, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
            [_botaoQuadro2 setFrame: CGRectMake(195, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
            
            [_quadro3 setFrame: CGRectMake(385, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
            [_botaoQuadro3 setFrame: CGRectMake(385, yLandscapeIphone, tamanhoQuadroLandscapeIphone, tamanhoQuadroLandscapeIphone)];
        }
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
