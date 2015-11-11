//
//  AddClientsViewController.m
//  ChatApp
//
//  Created by Rewa on 09/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "AddClientsViewController.h"
#import "ClientDetailsViewController.h"
#import "AppDelegate.h"
#import "Client.h"

@implementation AddClientsViewController
static int count;
- (void)viewDidLoad {
    [super viewDidLoad];
    //tableView.delegate=self;
    //tableView.dataSource=self;
    //[tableView reloadData];
    self.title = @"Client List";
    NSManagedObjectContext *context=self.managedObjectContext;
    context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    self.clients = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"%@",self.clients);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    NSManagedObjectContext *context=self.managedObjectContext;
    context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    self.clients = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Clients:%@",self.clients);
    NSLog(@"Count1:%lu",(unsigned long)self.clients.count);
    count=self.clients.count;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:(count-1) inSection:1];
    [self.tableView beginUpdates];
    [self.tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell=[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [cell reloadInputViews];
    [self.tableView reloadData];
}*/
/*-(void)sendDataToAddClientsViewController:(NSManagedObjectContext*)managedObjectContext
{
    //NSLog(@"%@",array);
    managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    self.clients = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //self.clients=array;
    //[self.view setNeedsDisplay];
    //[self viewDidLoad];
    //UITableView *tableView=[[UITableView alloc]init];
    NSLog(@"I am here");
    
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:(count-1) inSection:1];
    //[tableView.dataSource objectAtIndex:indexPath.row]=[self.clients objectAtIndex:indexPath.row];
    [self.tableView beginUpdates];
    int inte=[self.tableView numberOfRowsInSection:0];
    NSLog(@"%d",inte);
    [self.tableView cellForRowAtIndexPath:indexPath];
    [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    //NSManagedObject *client = [self.clients objectAtIndex:indexPath.row];
    //[self.tableView.dataSource tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:indexPath];
    //[self.tableView reloadData];
}*/
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"Count: %lu",(unsigned long)count);
    return self.clients.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog(@"Inside cell");
    NSString *reuseCell = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    
    NSManagedObject *client = [self.clients objectAtIndex:indexPath.row];
    //NSLog(@"%@",self.clients);
    //NSDictionary *cellDict = [self.clients objectAtIndex:indexPath.row];
    NSLog(@"cellDict:%@",self.clients);
    // UIImage *cellImg = [[UIImage ]
    
    
    //[cell.imageView setImage:[UIImage imageNamed:[cellDict objectForKey:@"imagename"]]];
    [cell.textLabel setText:[client valueForKey:@"name"]];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"Clients1:%@",self.clients);
    NSManagedObject *client = [self.clients objectAtIndex:indexPath.row];
    NSLog(@"I am here");
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ClientDetailsViewController *myDetailView = [myStoryBoard instantiateViewControllerWithIdentifier:@"ClientDetail"];
    myDetailView.clientDict=client;
    myDetailView.ind=indexPath.row;
    
    [self.navigationController pushViewController:myDetailView animated:TRUE];
    
    
}

- (IBAction)addClient:(id)sender {
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ClientDetailsViewController *myDetailView = [myStoryBoard instantiateViewControllerWithIdentifier:@"ClientDetail"];
    //myDetailView.clients = self.clients;
    //BViewController * bController=[[BViewController alloc] initWithNibName:@"BViewController" bundle:nil];
    myDetailView.delegate=self;
    
    [self.navigationController pushViewController:myDetailView animated:TRUE];
}
@end
