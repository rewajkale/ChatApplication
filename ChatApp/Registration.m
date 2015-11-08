//
//  Registration.m
//  ChatApp
//
//  Created by Rewa on 06/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "Registration.h"
#import "AppDelegate.h"
#import "Artist.h"
@interface Registration ()
{
}
@end

@implementation Registration
static int check=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    Artist *newArtist = (Artist *)[NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:moc];
    newArtist.username = self.ulbl.text;
    newArtist.password = self.plbl.text;
    newArtist.phoneNumber = self.pholbl.text;
    [self.artistsArray addObject:newArtist];*/
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
    self.artists = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    self.plbl.hidden=YES;
    self.lblp.hidden=YES;
    self.rplbl.hidden=YES;
    self.login.hidden=YES;
    self.registr.hidden=YES;
    self.lblr.hidden=YES;
    self.lblpho.hidden=YES;
    self.pholbl.hidden=YES;
    for (int i=0; i<[self.artists count]; i++) {
        NSManagedObject *artist = [self.artists objectAtIndex:i];
        if ([[artist valueForKey:@"username"] isEqualToString:self.ulbl.text]) {
            NSLog(@"Username exists");
            self.rplbl.hidden=YES;
            self.registr.hidden=YES;
            self.lblr.hidden=YES;
            self.lblpho.hidden=YES;
            self.pholbl.hidden=YES;
            break;
        }
        else
        {
            NSLog(@"No user registered");
            self.login.hidden=YES;
        }

    }
    
    //NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    /*if([self.artists.username isEqualToString:self.ulbl.text])
    {
        NSLog(@"User is registered");
        self.rplbl.hidden=YES;
        self.registr.hidden=YES;
        self.lblr.hidden=YES;
        self.lblpho.hidden=YES;
        self.pholbl.hidden=YES;    }
    else
    {
        NSLog(@"No user registered");
        self.login.hidden=YES;
    }*/
}
- (IBAction)checkAvail:(id)sender
{
    if([self.ulbl.text isEqualToString:@""])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"You must complete all the fields" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
    else
    {
        
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
        self.artists = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        if (!_artists||![_artists count]) {
            NSLog(@"No user registered");
            self.rplbl.hidden=NO;
            self.registr.hidden=NO;
            self.lblr.hidden=NO;
            self.lblpho.hidden=NO;
            self.pholbl.hidden=NO;
            self.plbl.hidden=NO;
            self.lblp.hidden=NO;
            self.login.hidden=YES;
        }
        for (int i=0; i<[self.artists count]; i++) {
            NSManagedObject *artist = [self.artists objectAtIndex:i];
            if ([[artist valueForKey:@"username"] isEqualToString:self.ulbl.text]) {
                NSLog(@"Username exists");
                self.rplbl.hidden=YES;
                self.registr.hidden=YES;
                self.lblr.hidden=YES;
                self.plbl.hidden=NO;
                self.lblp.hidden=NO;
                self.pholbl.hidden=YES;
                self.lblpho.hidden=YES;
                self.login.hidden=NO;
                break;
            }
            else
            {
                NSLog(@"No user registered");
                self.rplbl.hidden=NO;
                self.registr.hidden=NO;
                self.lblr.hidden=NO;
                self.lblpho.hidden=NO;
                self.pholbl.hidden=NO;
                self.plbl.hidden=NO;
                self.lblp.hidden=NO;
                self.login.hidden=YES;
            }
            
        }

    }
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login_user:(id)sender {
    /*NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];*/
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
    self.artists = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //NSInteger num=[self.artists indexOfObject:self.ulbl.text];
    //NSLog(@"%ld",[self.artists indexOfObject:self.plbl.text]);
    //NSLog(@"%ld",[self.artists indexOfObject:self.ulbl.text]);
    //NSLog(@"%d",[self.artists indexOfObject:self.plbl.text]!=NSNotFound);
    if([self.ulbl.text isEqualToString:@""]||[self.plbl.text isEqualToString:@""])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"You must complete all the fields" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
    //else if(([self.artists indexOfObject:self.plbl.text]!=NSNotFound)&&([self.artists indexOfObject:self.plbl.text] ==[self.artists indexOfObject:self.ulbl.text]))
    else
    {
        //int check=0;
        for (int i=0; i<[self.artists count]; i++) {
            NSManagedObject *artist = [self.artists objectAtIndex:i];
            if ([[artist valueForKey:@"username"] isEqualToString:self.ulbl.text]&&[[artist valueForKey:@"password"] isEqualToString:self.plbl.text]) {
                check=1;
                NSLog(@"Login credentials accepted");
            }
            
        }
        if (check==0) {
            NSLog(@"Login incorrect");
            UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"Username and password do not match" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [error show];
            [self shouldPerformSegueWithIdentifier:@"login" sender:(id)sender];
        }
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"%d",check);
    if(check==0)
    {
        self.ulbl.text=@"";
        self.plbl.text=@"";
        return NO;
    }
    else
    {
        return YES;
    }
}
- (IBAction)register_user:(id)sender {
        //[self dismissViewControllerAnimated:YES completion:nil];
    if([self.ulbl.text isEqualToString:@""]||[self.plbl.text isEqualToString:@""]||[self.rplbl.text isEqualToString:@""])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"You must complete all the fields" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
    else
    {
        int check=0;
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
        self.artists = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        for (int i=0; i<[self.artists count]; i++) {
            NSManagedObject *artist = [self.artists objectAtIndex:i];
            if ([[artist valueForKey:@"phoneNumber"] isEqualToString:self.pholbl.text]||[[artist valueForKey:@"username"] isEqualToString:self.ulbl.text]) {
                NSLog(@"Phone number or username exists");
                UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"Phone number or username already exists Enter again" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [error show];
                check=1;
            }
        }
        if(check==0)
        {
            [self checkPasswordsmatch];
        }
    }
}



-(void)checkPasswordsmatch {
    if([self.plbl.text isEqualToString:self.rplbl.text])
    {
        NSLog(@"Password match");
        [self register_new_user];
    }
    else
    {
        NSLog(@"Password dont match");
        UIAlertView *ermatch=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"Reenter the password" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [ermatch show];
    }

}
-(void) register_new_user
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newArtist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    [newArtist setValue:self.ulbl.text forKey:@"username"];
    [newArtist setValue:self.plbl.text forKey:@"password"];
    [newArtist setValue:self.pholbl.text forKey:@"phoneNumber"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
   /*
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.ulbl.text forKey:@"username"];
    [defaults setObject:self.plbl.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    [defaults synchronize];*/
    
    UIAlertView *success=[[UIAlertView alloc]initWithTitle:@"Success message" message:@"You have registered a new user" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [success show];
    
    [self performSegueWithIdentifier:@"login" sender:self];
}
@end
