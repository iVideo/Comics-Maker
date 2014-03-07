//
//  OCTirinhaViewController.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/6/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import "OCTirinhaViewController.h"

@interface OCTirinhaViewController ()

@end

@implementation OCTirinhaViewController
@synthesize ctx;

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
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 50);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(ctx, color);
    
    CGContextStrokePath(ctx);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
