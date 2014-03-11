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
	// Do any additional setup after loading the view.
    
    [join setImage:[[[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject] tirinhaCompleta]];
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
