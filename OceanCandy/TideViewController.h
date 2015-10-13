//
//  TideViewController.h
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright (c) 2015 Jian Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TideViewController : UIViewController <NSURLSessionDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSArray *lowTideArray;
@property (nonatomic, copy) NSArray *highTideArray;
@property (nonatomic, strong) UITableView *tideTableView;

@end
