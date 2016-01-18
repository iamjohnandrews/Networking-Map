//
//  ContactTableViewCell.h
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) Contact *contact;
@end
