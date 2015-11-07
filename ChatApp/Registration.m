//
//  Registration.m
//  ChatApp
//
//  Created by Rewa on 06/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "Registration.h"

@interface Registration ()

@end

@implementation Registration
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"registered"])
    {
        NSLog(@"No user registered");
        self.login.hidden=YES;
    }
    else
    {
        NSLog(@"User is registered");
        self.rplbl.hidden=YES;
        self.registr.hidden=YES;
        self.lblr.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login_user:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if([self.ulbl.text isEqualToString:[defaults objectForKey:@"username"]]&&[self.plbl.text isEqualToString:[defaults objectForKey:@"password"]])
    {
        NSLog(@"Login credentials accepted");
    }
    else
    {
        NSLog(@"Login incorrect");
    }
}

- (IBAction)register_user:(id)sender {
    if([self.ulbl.text isEqualToString:@""]||[self.plbl.text isEqualToString:@""]||[self.rplbl.text isEqualToString:@""])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"You must complete all the fields" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
    else
    {
        [self checkPasswordsmatch];
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
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.ulbl.text forKey:@"username"];
    [defaults setObject:self.plbl.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    [defaults synchronize];
    
    UIAlertView *success=[[UIAlertView alloc]initWithTitle:@"Success message" message:@"You have registered a new user" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [success show];
    
    [self performSegueWithIdentifier:@"login" sender:self];
}
@end
