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
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(ctx, 50);
//    
//    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
//    CGColorRef color = CGColorCreate(colorspace, components);
//    CGContextSetStrokeColorWithColor(ctx, color);
//    
//    CGContextStrokePath(ctx);
    OCTirinhasSingleton* sing = [[OCTirinhasSingleton alloc]init];
    
    
    OCQuadro* quad = [[OCQuadro alloc]init];
   
    quad = [[sing tirinhas]firstObject];
    
    UIImage* first = quad.imagem;

    
    CGSize newSize = CGSizeMake(209, 260); //size of image view
    UIGraphicsBeginImageContext( newSize );
    
    // drawing 1st image
    //[second drawInRect:CGRectMake(0,0,newSize.width/2,newSize.height/2)];
    
    // drawing the 2nd image after the 1st
    [first drawInRect:CGRectMake(0,newSize.height/2,newSize.width/2,newSize.height/2)] ;
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [join setImage: first];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
