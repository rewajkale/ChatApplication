//
//  AddC.h
//  ChatApp
//
//  Created by Rewa on 11/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addC;
@property (weak, nonatomic) IBOutlet UIButton *addCP;
- (IBAction)addClient:(id)sender;
- (IBAction)addClientP:(id)sender;

@end
