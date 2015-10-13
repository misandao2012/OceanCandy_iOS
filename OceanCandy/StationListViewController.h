//
//  StationListViewController.h
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright (c) 2015 Jian Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TideViewController;

@interface StationListViewController : UITableViewController

@property (nonatomic, copy) NSString *stateName;
@property (nonatomic, retain) NSMutableArray *allStations;
@property (nonatomic, retain) NSMutableArray *stations;
@property (nonatomic, retain) NSMutableArray *stationIds;
@property (nonatomic, strong) TideViewController *tideViewController;

@end
