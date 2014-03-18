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
    NSMutableArray* sing = [[OCTirinhasSingleton sharedTirinhas] tirinhas];
    OCTirinha *tira = [sing lastObject];
    if ([tira titulo]==nil) {
        [self insereTitulo];
    }
    else{
        UIImageWriteToSavedPhotosAlbum([join image], nil, nil, nil);
        // Determine Path
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
//        
//        // Archive Array
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sing];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"sing"];
//
        //[data writeToFile:path options:NSDataWritingAtomic error:nil];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sing];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"notes"];
        
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
    [[self navigationItem] setTitle:titulo];
    [_botaoConcluido setTitle:@"Ok" forState:UIControlStateNormal];
    UIImageWriteToSavedPhotosAlbum([join image], nil, nil, nil);
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Salvo na biblioteca" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alerta show];
    [self performSelector:@selector(test:) withObject:alerta afterDelay:1.2];
}

-(void)test:(UIAlertView *)x {
	[x dismissWithClickedButtonIndex:-1 animated:YES];
}

-(void)insereTitulo{
    myAlertView = [[UIAlertView alloc]initWithTitle:@"Informe um nome:" message:nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ok", nil];
    [myAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [myAlertView show];
}


@end
