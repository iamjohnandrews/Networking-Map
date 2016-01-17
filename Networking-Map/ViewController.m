//
//  ViewController.m
//  Networking-Map
//
//  Created by John Andrews on 1/16/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"

NSString *const citrixProjectURL = @"http://nsmith.nfshost.com/sf/contacts.json";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveContactsJSON];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark Networking Methods

- (void)retrieveContactsJSON {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:citrixProjectURL]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:nil];
            NSLog(@"retrieved from the Internet %@", dict);
            [self parseResponse:dict];
        }
    }] resume];
}

- (void)parseResponse:(NSDictionary *)jsonDict {
    
}



#pragma mark TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark TableView Delegate Methods


@end
