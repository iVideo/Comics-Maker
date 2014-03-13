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
    UIView *vi;
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
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return join;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
    [[self navigationItem] setHidesBackButton:YES];
	// Do any additional setup after loading the view.
    
    [join setImage:[[[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject] tirinhaCompleta]];

}


- (IBAction)concluido:(id)sender {
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaViewController"];
    [self.navigationController setViewControllers:[[NSArray alloc] initWithObjects:table,nil]animated:YES];
}

@end
