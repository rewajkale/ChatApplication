//
//  AddC.m
//  ChatApp
//
//  Created by Rewa on 11/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "AddC.h"
#import "AddClientsViewController.h"
#import "PhoneContactList.h"

@implementation AddC
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.managedObjectContext = [self managedObjectContext];
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    //self.clients = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //NSLog(@"%@",self.clients);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClient:(id)sender {
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    AddClientsViewController *myDetailView = [myStoryBoard instantiateViewControllerWithIdentifier:@"addClients"];
    [self.navigationController pushViewController:myDetailView animated:YES];
}

- (IBAction)addClientP:(id)sender {
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PhoneContactList *myDetailView = [myStoryBoard instantiateViewControllerWithIdentifier:@"phoneContact"];
    [self.navigationController pushViewController:myDetailView animated:YES];
}
@end
