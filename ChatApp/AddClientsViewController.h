//
//  AddClientsViewController.h
//  ChatApp
//
//  Created by Rewa on 09/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientDetailsViewController.h"
@interface AddClientsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    //NSMutableArray *clients;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addClient;

@property NSMutableArray *clients;
//@property UITableView *tableView;
@property AppDelegate *managedObjectContext;
- (IBAction)addClient:(id)sender;
@end
