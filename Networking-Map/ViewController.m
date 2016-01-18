//
//  ViewController.m
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"

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
    
    return cell;
}

#pragma mark Segue Method




@end
