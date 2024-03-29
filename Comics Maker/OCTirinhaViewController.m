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
#import "testaViewController.h"
#import "OCMontaTirinhaViewController.h"
#import <objc/message.h>
#import <Social/Social.h>

@interface OCTirinhaViewController ()
@property (strong, nonatomic) UIActivityViewController *activityViewController;
@end

@implementation OCTirinhaViewController{
    UIAlertView *myAlertView;
}
@synthesize ctx;
@synthesize tirinha;
@synthesize join;

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
//}
//
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
        if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
            if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
                [join setFrame: CGRectMake(0, 380, 768, 256)];
            }
            else{
                [join setFrame:CGRectMake(0, 220, 1024, 341)];
            }
        } else {
            if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
                [join setFrame: CGRectMake(0, 230, 320, 108)];
            }
            else{
                [join setFrame:CGRectMake(0, 70, 570, 190)];
            }
        }
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationItem] setHidesBackButton:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return join;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaView"];
        [[self navigationController] setViewControllers:[[NSArray alloc] initWithObjects:table, nil] animated:YES];

        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sing];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"notes"];
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
}

-(void)insereTitulo{
    myAlertView = [[UIAlertView alloc]initWithTitle:@"Informe um título:" message:nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ok", nil];
    [myAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [myAlertView show];
}

- (IBAction)compartilhar:(id)sender {
    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[join.image] applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self compartilharNoFacebook];
                    //[self presentViewController:fbController animated:YES completion:nil];
                    break;
                case 1:
                    [self compartilharNoTwitter];
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


#pragma - mark compartilhamentos
- (void)compartilharNoFacebook
{
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            [fbController dismissViewControllerAnimated:YES completion:nil];
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }
        };
        
        
        [fbController setInitialText:[tirinha titulo]];
        
        [fbController addImage:[tirinha tirinhaCompleta]];
        
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login!" message:@"Por favor, efetue login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void)compartilharNoTwitter{
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            [fbController dismissViewControllerAnimated:YES completion:nil];
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }
        };
        
        [fbController setInitialText:[tirinha titulo]];
        [fbController addImage:[tirinha tirinhaCompleta]];
        
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login!" message:@"Por favor, efetue login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)editar:(id)sender {
    OCTirinhasSingleton *single = [OCTirinhasSingleton sharedTirinhas];
    [single setNovaTirinha:NO];
    [single setEditandoTirinha:YES];
    OCMontaTirinhaViewController *monta = [self.storyboard instantiateViewControllerWithIdentifier:@"montaTirinha"];
    [monta recebeTirinha:tirinha];
    [tirinha setTirinhaPequena:nil];
    [[self navigationController] pushViewController:monta animated:YES];
//    [[self navigationController] setViewControllers:[[NSArray alloc] initWithObjects:monta, nil] animated:YES];
}

@end
