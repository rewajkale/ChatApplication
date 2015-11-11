//
//  ClientDetailsViewController.h
//  ChatApp
//
//  Created by Rewa on 09/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/*@protocol senddataProtocol <NSObject>
-(void)sendDataToAddClientsViewController:(NSManagedObjectContext*) managedObjectContext;
@end*/
@interface ClientDetailsViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet UITextField *nlbl;
@property (weak, nonatomic) IBOutlet UITextField *elbl;
@property (weak, nonatomic) IBOutlet UITextField *pholbl;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (strong) NSMutableArray *clients;
@property NSManagedObject *newclient;
@property AppDelegate *managedObjectContext;
@property NSMutableDictionary *clientDict;
@property NSInteger *ind;
- (IBAction)addClient:(id)sender;
- (NSManagedObjectContext *)managedObjectContext;

@end
