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
}

-(BOOL)shouldAutorotate{
    return NO;
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

-(void)insereImagemNosQuadros{
    if (![single novaTirinha]) {
        [_quadro1 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:0] imagem]];
        [_quadro2 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:1] imagem]];
        [_quadro3 setImage:[[[[[single tirinhas] lastObject] quadros] objectAtIndex:2] imagem]];
    }
}
- (IBAction)cancelar:(id)sender {
    [[single tirinhas] removeLastObject];
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
    [self.navigationController pushViewController:table animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
