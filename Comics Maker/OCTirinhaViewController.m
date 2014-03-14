//
//  OCTirinhaViewController.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/6/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import "OCTirinhaViewController.h"
#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"
#import "OCQuadro.h"
#import "OCTableViewController.h"
#import <objc/message.h>

@interface OCTirinhaViewController ()
@end

@implementation OCTirinhaViewController{
    UIAlertView *myAlertView;
}
@synthesize ctx;
@synthesize tirinha;
@synthesize join;
@synthesize scrollView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(void)viewDidAppear:(BOOL)animated
{
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft );
    [[self navigationItem] setHidesBackButton:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return join;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
    [[self navigationItem] setHidesBackButton:YES];
    
    if (!tirinha) {
        tirinha = [[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject];
    }
    
    [join setImage:[tirinha tirinhaCompleta]];
}


- (IBAction)concluido:(id)sender {
    OCTirinha *tira = [[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject];
    if ([tira titulo]==nil) {
        [self insereTitulo];
    }
    else{
        UIImageWriteToSavedPhotosAlbum([join image], nil, nil, nil);
        OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaViewController"];
        [self.navigationController setViewControllers:[[NSArray alloc] initWithObjects:table,nil]animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        return;
    }
    NSString *titulo = [myAlertView textFieldAtIndex:0].text;
    OCTirinha *tira = [[[OCTirinhasSingleton sharedTirinhas]tirinhas] lastObject];
    [tira setTitulo:titulo];
    [_botaoConcluido setTitle:@"Ok" forState:UIControlStateNormal];

}

-(void)insereTitulo{
    myAlertView = [[UIAlertView alloc]initWithTitle:@"Informe um nome:" message:nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ok", nil];
    [myAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [myAlertView show];
}


@end
