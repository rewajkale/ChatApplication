//
//  PhoneContactList.h
//  ChatApp
//
//  Created by Rewa on 11/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PhoneContactList : UITableViewController<UIAlertViewDelegate>
@property NSMutableArray *contactList;
@property AppDelegate *managedObjectContext;
@property NSManagedObject *newclient;
@property NSManagedObjectContext *context;
@end
