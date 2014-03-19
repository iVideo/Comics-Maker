//
//  testaViewController.m
//  Comics Maker
//
//  Created by Rodrigo Soldi Lopes on 19/03/14.
//  Copyright (c) 2014 Rodrigo Soldi Lopes. All rights reserved.
//

#import "testaViewController.h"
#import "OCTirinhasSingleton.h"

@interface testaViewController ()

@end

@implementation testaViewController

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
    OCTirinhasSingleton *single = [OCTirinhasSingleton sharedTirinhas];
    
    if (single.tirinhas.count==0) {
        [self performSegueWithIdentifier:@"vazio" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"tabela" sender:self];
    }
    
    [super viewDidLoad];
    [[self navigationItem] setHidesBackButton:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
