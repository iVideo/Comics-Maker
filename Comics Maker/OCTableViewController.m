//
//  OCTableViewController.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//


/*
    Essa table view irá pegar as informacoes do Singleton: OCImagemSingleton.
    O mesmo conterá todas as tirinhas prontas.

*/

#import <Social/Social.h>
#import "OCTableViewController.h"
#import "OCTirinhaViewController.h"


@interface OCTableViewController ()
@property NSInteger index;
@end

@implementation OCTableViewController
@synthesize single;
@synthesize index;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return YES;
}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationPortrait;
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
    
    [[self navigationController] setDelegate:self];

    //Pegando instancia unica do singleton para usar por todo o .m    
    single = [OCTirinhasSingleton sharedTirinhas];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    single.quadroAtual=0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[single tirinhas] count];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    OCTirinha *from = [[single tirinhas]objectAtIndex:[fromIndexPath row]];
    OCTirinha *to = [[single tirinhas]objectAtIndex:[toIndexPath row]];
    
    [[single tirinhas] replaceObjectAtIndex:[fromIndexPath row] withObject:to];
    [[single tirinhas]replaceObjectAtIndex:[toIndexPath row] withObject:from];
}



 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
     // Return NO if you do not want the item to be re-orderable.
     return YES;
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OCTirinha *tira = [[single tirinhas]objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[tira titulo]];
    
    return cell;
}


- (IBAction)edit:(id)sender {
    if ([[self tableView] isEditing]) {
        [[self tableView] setEditing:NO];
        [_edit setTitle:@"Editar" forState:UIControlStateNormal];
    }else
    {
        [[self tableView] setEditing:YES];
        [_edit setTitle:@"Ok" forState:UIControlStateNormal];
    }

}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[single tirinhas] removeObjectAtIndex:[indexPath row]];
        [tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OCTirinhaViewController *tirinha = [self.storyboard instantiateViewControllerWithIdentifier:@"TirinhaViewController"];
    [[self navigationController] setViewControllers:[[NSArray alloc] initWithObjects:tirinha, nil] animated:YES];
    [[tirinha botaoConcluido] setTitle:@"Ok" forState:UIControlStateNormal];
    
    OCTirinha *tira = [[single tirinhas] objectAtIndex:[indexPath row]];
    tirinha.tirinha = tira;
    //[[tirinha join] setImage:[tira tirinhaCompleta]];
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    index = [indexPath row];
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:@"Compartilhar" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self compartilharNoFacebook];
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
        
        OCTirinha *tirinha = [[single tirinhas]objectAtIndex:index];
        
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
        
        OCTirinha *tirinha = [[single tirinhas]objectAtIndex:index];
        
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*




/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
