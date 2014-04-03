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
#import "OCMontaTirinhaViewController.h"


@interface OCTableViewController ()
@property NSInteger index;
@property NSString *tituloTable;
@property NSArray *resultados;
@end

@implementation OCTableViewController
@synthesize single;
@synthesize index;
@synthesize tituloTable;
@synthesize data;
@synthesize resultados;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{

    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"titulo contains[c] %@", searchText];
    self.resultados = [[[NSArray alloc] initWithArray:[single tirinhas]] filteredArrayUsingPredicate:resultPredicate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
    
    [[self navigationController] setDelegate:self];
    [[self tableView] setAllowsMultipleSelection:YES];
    
    resultados = [[NSArray alloc]init];
    
    single = [OCTirinhasSingleton sharedTirinhas];
    data = [NSKeyedArchiver archivedDataWithRootObject:single.tirinhas];
    [single setNovaTirinha:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    single.quadroAtual = 0;
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.resultados count];
        
    }
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
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    OCTirinha *tira = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tira = [self.resultados objectAtIndex:indexPath.row];
    } else {
        tira = [[single tirinhas] objectAtIndex:indexPath.row];
    }
    
    [[cell textLabel] setText:[tira titulo]];
    [[cell imageView] setImage:[tira tirinhaPequena]];
    
    return cell;
}

- (IBAction)edit:(id)sender
{
    if ([[self tableView] isEditing]) {
        [[self tableView] setEditing:NO];
        [_edit setTitle:@"Editar" forState:UIControlStateNormal];
        [[self navigationItem] setTitle:@"Tirinhas"];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(criaTirinha)] ;
        [[self navigationItem] setRightBarButtonItem:barButtonItem];
        [[[self navigationItem] rightBarButtonItem] setTintColor:[UIColor whiteColor]];
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
    OCMontaTirinhaViewController *tirinha = [self.storyboard instantiateViewControllerWithIdentifier:@"montaTirinha"];
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"visualizar"]) {
        NSIndexPath *indexPath = nil;
        OCTirinha *tira = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            tira = [self.resultados objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            tira = [[single tirinhas] objectAtIndex:indexPath.row];
        }
        
        OCTirinhaViewController *destViewController = segue.destinationViewController;
        destViewController.tirinha = tira;
        
        [[destViewController navigationItem] setTitle:[tira titulo]];
    }
    
    if ([segue.identifier isEqualToString:@"novaTirinha"]) {
        [single setEditandoTirinha:NO];
    }
}

-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (popup.tag) {
        case 1:
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


@end
