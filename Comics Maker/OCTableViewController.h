//
//  OCTableViewController.h
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTirinha.h"
#import "OCTirinhasSingleton.h"

@interface OCTableViewController : UITableViewController <UINavigationBarDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, NSCoding, UISearchBarDelegate, UISearchDisplayDelegate>
@property OCTirinhasSingleton *single;
@property NSData* data;
@property (weak, nonatomic) IBOutlet UIButton *edit;

@end
