//
//  Registration.h
//  ChatApp
//
//  Created by Rewa on 06/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface Registration : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ulbl;
@property (weak, nonatomic) IBOutlet UITextField *plbl;
@property (weak, nonatomic) IBOutlet UITextField *rplbl;
@property (weak, nonatomic) IBOutlet UIButton *login;

@property (weak, nonatomic) IBOutlet UIButton *registr;

@property (weak, nonatomic) IBOutlet UILabel *lblr;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)login_user:(id)sender;
- (IBAction)register_user:(id)sender;

@end

