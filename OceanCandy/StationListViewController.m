//
//  StationListViewController.m
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright (c) 2015 Jian Zhang. All rights reserved.
//

#import "StationListViewController.h"
#import "TideViewController.h"

@implementation StationListViewController

@synthesize stateName, allStations, stations, tideViewController, stationIds;

-(instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    [self setupStationsArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stations count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tideViewController = [[TideViewController alloc] init];
    tideViewController.stationId = stationIds[indexPath.row];
    [self.navigationController pushViewController:(UIViewController *)tideViewController
                                         animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = stations[indexPath.row];
    return cell;
}

-(void) setupStationsArray {
    stations = [[NSMutableArray alloc] init];
    stationIds = [[NSMutableArray alloc] init];
    for (int i=0; i<[allStations count]; i++) {
        NSMutableDictionary *dict = [allStations objectAtIndex:i];
        NSString *state=[dict valueForKey:@"state_name"];
        if([state isEqualToString:stateName]){
            [stations addObject:[dict valueForKey:@"name"]];
            [stationIds addObject:[dict valueForKey:@"id"]];
        }
    }
    [self.tableView reloadData];
}

@end
