//
//  OCViewController.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCViewController.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)pesquisaFotoButton:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentModalViewController:picker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_currentImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    OCTirinhasSingleton *tirinhasSingleton = [OCTirinhasSingleton sharedTirinhas];
    OCTirinha *novaTirinha = [tirinhasSingleton.tirinhas lastObject];
    [novaTirinha setImage:_currentImage.image forQuadroAtIndex:0];
    
}
@end
