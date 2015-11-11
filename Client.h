//
//  Client.h
//  ChatApp
//
//  Created by Rewa on 09/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Client : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) Artist *clients;

@end
