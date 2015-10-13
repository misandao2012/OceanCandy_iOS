//
//  StateListViewController.h
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright (c) 2015 Jian Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StationListViewController;

@interface StateListViewController : UITableViewController

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, retain) NSMutableArray *stateNames;
@property (nonatomic, retain) NSMutableArray *stations;
@property (nonatomic, strong) StationListViewController *stationListViewController;


@end
