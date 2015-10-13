//
//  StateListViewController.m
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright © 2015 Jian Zhang. All rights reserved.
//

#import "StateListViewController.h"
#import "StationListViewController.h"

@interface StateListViewController() <NSURLSessionDelegate>

@end

@implementation StateListViewController

@synthesize session, stateNames, stationListViewController, stations;

- (instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        stateNames = [[NSMutableArray alloc] init];
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        
        session = [NSURLSession sessionWithConfiguration:config
                                                     delegate:self
                                                delegateQueue:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpGet: @"http://oceancandy.clank.us/stations"];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stateNames count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    stationListViewController = [[StationListViewController alloc] init];
    stationListViewController.stateName = stateNames[indexPath.row];
    stationListViewController.allStations = stations;
    [self.navigationController pushViewController:(UIViewController *)stationListViewController
                                         animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = stateNames[indexPath.row];
    return cell;
}

- (void)httpGet:(NSString *)requestString {
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithRequest:req
                    completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         stations= [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error: &error];
         for (int i=0; i<[stations count]; i++) {
             NSMutableDictionary *dict=[stations objectAtIndex:i];;
             NSString *stateName=[dict valueForKey:@"state_name"];
             if(![stateNames containsObject:stateName]){
                 [stateNames addObject:stateName];
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
    [dataTask resume];
}

@end

