//
//  PhoneContactList.m
//  ChatApp
//
//  Created by Rewa on 11/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import "PhoneContactList.h"
#import <AddressBook/AddressBook.h>
@implementation PhoneContactList
static int check=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //dispatch_release(<#dispatch_object_t object#>);
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressBook];
    }
    
    if (accessGranted) {
        [self getContactsWithAddressBook:addressBook];
    }
    // Do any additional setup after loading the view, typically from a nib.
    
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

// Get the contacts.
- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    _contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
        }
        [_contactList addObject:dOfPerson];
        
    }
    NSLog(@"Contacts = %@",_contactList);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //NSLog(@"Count: %lu",(unsigned long)count);
    return self.contactList.count;
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
    
    NSDictionary *client = [self.contactList objectAtIndex:indexPath.row];
    //NSLog(@"%@",self.clients);
    //NSDictionary *cellDict = [self.clients objectAtIndex:indexPath.row];
    NSLog(@"cellDict:%@",client);
    // UIImage *cellImg = [[UIImage ]
    
    
    //[cell.imageView setImage:[UIImage imageNamed:[cellDict objectForKey:@"imagename"]]];
    [cell.textLabel setText:[client valueForKey:@"name"]];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *aerror=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"Do you really want to add this contact to your client list?" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
    [aerror show];
    //NSLog(@"Clients1:%@",self.clients);
    NSDictionary *dict=[self.contactList objectAtIndex:indexPath.row];
    NSLog(@"Check:%d",check);
    self.context = [self managedObjectContext];
    self.newclient = [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:self.context];
    [self.newclient setValue:[dict valueForKey:@"name"] forKey:@"name"];
    [self.newclient setValue:[dict valueForKey:@"email"] forKey:@"email"];
    [self.newclient setValue:[dict valueForKey:@"Phone"] forKey:@"phoneNumber"];
    self.managedObjectContext = (AppDelegate*)self.context;
    
    //[self.navigationController popToViewController:myDetailView animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        check=1;
        NSError *error = nil;
        // Save the object to persistent store
        if (![self.context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            
        }
    }
}

@end
