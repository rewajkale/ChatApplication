//
//  ClientDetailsViewController.m
//  ChatApp
//
//  Created by Rewa on 09/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "ClientDetailsViewController.h"
#import "AddClientsViewController.h"
#import "Client.h"
#import "AppDelegate.h"

@implementation ClientDetailsViewController
static int check=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
    self.navigationItem.leftBarButtonItem=barButton;
    self.nlbl.delegate=self;
    self.elbl.delegate=self;
    self.pholbl.delegate=self;
    NSLog(@"%@",self.clientDict);
    if(!self.clientDict)
    {
        NSLog(@"Dict is empty");
    }
    else
    {
        self.add.hidden=TRUE;
        check=1;
        self.nlbl.text=[self.clientDict valueForKey:@"name"];
        self.elbl.text=[self.clientDict valueForKey:@"email"];
        self.pholbl.text=[self.clientDict valueForKey:@"phoneNumber"];
        //[self.clientDict removeAllObjects];
        //NSLog(@"%lu",(unsigned long)[self.clientDict count]);
    }
    //self.managedObjectContext = [self managedObjectContext];
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    //self.clients = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //NSLog(@"%@",self.clients);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (IBAction)addClient:(id)sender {
    NSCharacterSet *alphanum=[NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myString=[NSCharacterSet characterSetWithCharactersInString:self.pholbl.text];
    BOOL valid=[alphanum isSupersetOfSet:myString];
    if([self.nlbl.text isEqualToString:@""]||[self.elbl.text isEqualToString:@""]||[self.pholbl.text isEqualToString:@""])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"You must complete all the fields" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
        //check=1;
    }
    else if(!valid)
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"PhoneNumber can only contain numbers" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
    else{
        check=0;
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
        self.clients = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        for (int i=0; i<[self.clients count]; i++) {
            NSManagedObject *client = [self.clients objectAtIndex:i];
            if ([[client valueForKey:@"email"] isEqualToString:self.elbl.text]||[[client valueForKey:@"phoneNumber"] isEqualToString:self.pholbl.text]) {
                NSLog(@"Phone number or email exists");
                UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Phone number or email address already exists Enter again" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [error show];
                check=1;
            }
        }
        if(check==0)
        {
            NSManagedObjectContext *context = [self managedObjectContext];
            self.newclient = [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:context];
            [self.newclient setValue:self.nlbl.text forKey:@"name"];
            [self.newclient setValue:self.elbl.text forKey:@"email"];
            [self.newclient setValue:self.pholbl.text forKey:@"phoneNumber"];
            self.managedObjectContext = (AppDelegate*)context;
            
            //[self.navigationController popToViewController:myDetailView animated:YES];
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                check=1;
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                

            }
        }
      //  UIViewController *backController=[self.storyboard instantiateViewControllerWithIdentifier:@"addClient"];
        //[[self navigationController]popViewControllerAnimated:YES];
    }
    //[self shouldPerformSegueWithIdentifier:@"goBack" sender:(id)sender];

}
/*-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if(check==1)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@synthesize delegate;
-(void)viewWillDisappear:(BOOL)animated
{
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Client"];
    //self.clients = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //AddClientsViewController *myDetailView = [myStoryBoard instantiateViewControllerWithIdentifier:@"addClients"];
    //self.clients =[[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //NSLog(@"myDetailView: %@",self.clients);
    //[delegate sendDataToAddClientsViewController:self.managedObjectContext];
}
-(void)handleBack:(id)sender
{
    NSLog(@"YES");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
