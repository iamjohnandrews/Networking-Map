//
//  ViewController.h
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

