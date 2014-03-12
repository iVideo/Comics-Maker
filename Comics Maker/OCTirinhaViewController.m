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

@interface OCTirinhaViewController ()

@end

@implementation OCTirinhaViewController
@synthesize ctx;
@synthesize tirinha;
@synthesize join;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setHidesBackButton:YES];
	// Do any additional setup after loading the view.
    
    [join setImage:[[[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject] tirinhaCompleta]];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"Altura da view: %f \n Largura da view: %f",self.view.bounds.size.width,self.view.bounds.size.height);
    int cw = self.view.frame.size.width;
    int ch = self.view.frame.size.height;
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
        //[join setFrame:CGRectMake((cw/2)-160, (ch/2)-251, 320, 502)];
    }
    else{
        //[join setFrame:CGRectMake(0, 0, 320, 200)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)concluido:(id)sender {
    OCTableViewController *table = [self.storyboard instantiateViewControllerWithIdentifier:@"TabelaViewController"];
    [self.navigationController setViewControllers:[[NSArray alloc] initWithObjects:table,nil]animated:YES];
}

@end
