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
#import "OCViewController.h"


@interface OCTableViewController ()
@property NSInteger index;
@property NSString *tituloTable;
@end

@implementation OCTableViewController
@synthesize single;
@synthesize index;
@synthesize tituloTable;
@synthesize data;

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
    [[self tableView] setAllowsMultipleSelection:YES];

    //Pegando instancia unica do singleton para usar por todo o .m    
    single = [OCTirinhasSingleton sharedTirinhas];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:single.tirinhas];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    single.quadroAtual=0;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return YES;
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OCTirinha *tira = [[single tirinhas]objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[tira titulo]];
    [[cell imageView] setImage:[tira tirinhaCompleta]];
    return cell;
}

- (IBAction)edit:(id)sender {
    
    if ([[self tableView] isEditing]) {
        [[self tableView] setEditing:NO];
        [_edit setTitle:@"Editar" forState:UIControlStateNormal];
        [[self navigationItem] setTitle:@"Tirinhas"];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(criaTirinha)] ;
        [[self navigationItem] setRightBarButtonItem:barButtonItem];
    }
    else
    {
        [[self tableView] setEditing:YES];
        [_edit setTitle:@"OK" forState:UIControlStateNormal];
        tituloTable = [[self navigationItem] title];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc]init];
        [barButton setTarget:self];
        [barButton setAction:@selector(deletaTodasTirinhas)];
        [[self navigationItem] setRightBarButtonItem:barButton];
        [[[self navigationItem] rightBarButtonItem]setTintColor:[UIColor whiteColor]];
        [[[self navigationItem] rightBarButtonItem] setImage:nil];
        [[[self navigationItem] rightBarButtonItem] setTitle:@"Apagar tudo"];
        
        [[self navigationItem] setTitle:[[[[[self navigationItem] title] stringByAppendingString:@" ("] stringByAppendingString:[NSString stringWithFormat:@"%d",single.tirinhas.count]]stringByAppendingString:@")"]];
    }

}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    if ([actionSheet tag]==2) {
        for (UIView *subview in actionSheet.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                return;
            }
        }
    }
}

-(void)deletaTodasTirinhas{
    UIActionSheet *popup = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Deletar Todas As Tirinhas", nil];
    popup.tag = 2;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)criaTirinha{
    OCViewController *tirinha = [self.storyboard instantiateViewControllerWithIdentifier:@"novaTirinha"];
    [[self navigationController] pushViewController:tirinha animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[single tirinhas] removeObjectAtIndex:[indexPath row]];
        [tableView reloadData];
        data = [NSKeyedArchiver archivedDataWithRootObject:single.tirinhas];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"notes"];
        
        [[self navigationItem] setTitle:[[[@"Tirinhas" stringByAppendingString:@" ("] stringByAppendingString:[NSString stringWithFormat:@"%d",single.tirinhas.count]]stringByAppendingString:@")"]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OCTirinhaViewController *tirinha = [self.storyboard instantiateViewControllerWithIdentifier:@"TirinhaViewController"];
    [[self navigationController] setViewControllers:[[NSArray alloc] initWithObjects:tirinha, nil] animated:YES];
    [[tirinha botaoConcluido] setTitle:@"Ok" forState:UIControlStateNormal];

    OCTirinha *tira = [[single tirinhas] objectAtIndex:[indexPath row]];
    tirinha.tirinha = tira;
    [[tirinha navigationItem] setTitle: [tira titulo]];
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
        case 2:
            switch (buttonIndex) {
                case 0:
                    [[single tirinhas] removeAllObjects];
                    data = [NSKeyedArchiver archivedDataWithRootObject:single.tirinhas];
                    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"notes"];
                    [[self tableView] reloadData];
                    
                    break;
                default:
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
