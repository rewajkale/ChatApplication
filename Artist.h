//
//  Artist.h
//  ChatApp
//
//  Created by Rewa on 07/11/15.
//  Copyright (c) 2015 Rewa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phoneNumber;

@end
