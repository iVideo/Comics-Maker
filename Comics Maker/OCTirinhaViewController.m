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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

            
            
//-(BOOL)shouldAutorotate
//{
//    
//    return NO;
//    
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    
//    return UIInterfaceOrientationMaskLandscape;
//    
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    
//    return UIInterfaceOrientationLandscapeLeft;
//    
//}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return join;
}
-(void)setContentSizeForScrollView
{
    scrollView.contentSize = CGSizeMake(join.frame.size.width, join.frame.size.height);
    //scrollview.minimumZoomScale = 1.0;
    //scrollview.maximumZoomScale = 5.0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
    [[self navigationItem] setHidesBackButton:YES];
	// Do any additional setup after loading the view.
    
    [join setImage:[[[[OCTirinhasSingleton sharedTirinhas] tirinhas] lastObject] tirinhaCompleta]];
    
    //scrollview = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
//    [scrollview setDelegate:self];
//    [scrollview setPagingEnabled:NO];
//    [[self view] addSubview: scrollview];
//    
//    CGRect bigRect = join.frame;
//    bigRect.size.width *= 5.0;
//    bigRect.size.height *= 5.0;
//    
//    [scrollview setMinimumZoomScale:1.0];
//    [scrollview setMaximumZoomScale:10.0];
//    
//    [scrollview addSubview:join];
//    [scrollview setContentSize:bigRect.size];
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    int cw = self.view.frame.size.width;
//    int ch = self.view.frame.size.height;
//    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
//        //[join setFrame:CGRectMake((cw/2)-285, (ch/2)-108, 570, 268)];
//        //[scrollView setFrame:CGRectMake((cw/2)-285, (ch/2)-108, 570, 268)];
//    }
//}



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
