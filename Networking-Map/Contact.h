//
//  Contact.h
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *parent;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *managers;
@property (nonatomic, strong) NSArray *phoneNumbers;
@property (nonatomic, strong) NSArray *addresses;
@end
