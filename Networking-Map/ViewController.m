//
//  ViewController.m
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

static NSString *citrixProjectURL = @"http://nsmith.nfshost.com/sf/contacts.json";
static NSString *CellIdentifier = @"infoCell";

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *contacts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveContactsJSON];
    
    self.tableView.dataSource = self;
}

#pragma mark Networking Methods

- (void)retrieveContactsJSON {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:citrixProjectURL]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    ViewController *__weak weakSelf = self;
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:nil];
            [self parseResponse:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
               [weakSelf.tableView reloadData];
            });
        }
    }] resume];

}

- (void)parseResponse:(NSDictionary *)jsonDict {
    NSDictionary *allContactsDict = [jsonDict objectForKey:@"contacts"];
    self.contacts = [NSMutableArray array];
    
    for (NSDictionary *contactDict in allContactsDict) {
        Contact *contact = [[Contact alloc] init];
        contact.companyName = [contactDict objectForKey:@"companyName"];
        contact.managers = [contactDict objectForKey:@"managers"];
        contact.parent = [contactDict objectForKey:@"parent"];
        contact.phoneNumbers = [contactDict objectForKey:@"phones"];
        contact.addresses = [contactDict objectForKey:@"addresses"];
        contact.name = [contactDict objectForKey:@"name"];

        [self.contacts addObject:contact];
    }
}


#pragma mark TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contact = self.contacts[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(ContactTableViewCell *)senderCell {
    if ([segue.identifier isEqualToString:@"toMapSegue"]) {
        MapViewController *mapViewController = segue.destinationViewController;
        mapViewController.contact = senderCell.contact;
        mapViewController.contact.addresses = @[@"701 Corporate Center Drive, Raleigh, NC 27607", @"4140 Parklake Ave #320, Raleigh, NC 27612"];
    }
}


@end
