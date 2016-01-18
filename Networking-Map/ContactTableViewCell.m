//
//  ContactTableViewCell.m
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)setContact:(Contact *)contact {
    [self populateTextView:contact];
}
/*
 NSString *companyName;
 NSString *parent;
 NSString *name;
 NSArray *managers;
 NSArray *phoneNumbers;
 NSArray *addresses;
*/

- (void)populateTextView:(Contact *)contact {
    
    NSString *displayString = contact.companyName ? contact.companyName : contact.name;
    NSString *managers = [self convertArrayContentsToString:contact.managers];
    NSString *phone = [self convertArrayContentsToString:contact.phoneNumbers];
    NSString *addresses = [self convertArrayContentsToString:contact.addresses];
    
    if (contact.parent) {
        displayString = [NSString stringWithFormat:@"%@\n%@", displayString, contact.parent];
    }
    if (managers) {
        displayString = [NSString stringWithFormat:@"%@%@", displayString, managers];
    }
    if (phone) {
        displayString = [NSString stringWithFormat:@"%@%@", displayString, phone];
    }
    if (addresses) {
        displayString = [NSString stringWithFormat:@"%@%@", displayString, addresses];
    }
    
    self.textView.text = displayString;
}

- (NSString *)convertArrayContentsToString:(NSArray *)array {
    if (!array) {
        return nil;
    }
    NSString *combinedString = @"";

    for (NSString *string in array) {
        combinedString = [NSString stringWithFormat:@"%@\n%@", combinedString, string];
    }

    return combinedString;
}

@end
