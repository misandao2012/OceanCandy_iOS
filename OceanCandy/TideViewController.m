//
//  TideViewController.m
//  OceanCandy
//
//  Created by Jian Zhang on 10/12/15.
//  Copyright (c) 2015 Jian Zhang. All rights reserved.
//

#import "TideViewController.h"

@interface TideViewController () {}

@end

@implementation TideViewController

@synthesize stationId, session, tideTableView, lowTideArray, highTideArray;

- (instancetype) init {
    self = [super init];
    if (self) {
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
    CGRect bounds = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    tideTableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    tideTableView.delegate = self;
    tideTableView.dataSource = self;
    [self.view addSubview: tideTableView];
    NSString *requestString = [NSString stringWithFormat:@"http://oceancandy.clank.us/stations/%@", stationId];
    [self httpGet: requestString];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return [lowTideArray count];
    } else {
        return [highTideArray count];
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    UILabel *timeLabel;
    UILabel *feetLabel;
    UILabel *timeValue;
    UILabel *feetValue;

    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TideViewControllerCell"];
        timeLabel = [[UILabel alloc]init];
        feetLabel = [[UILabel alloc]init];
        timeValue = [[UILabel alloc]init];
        feetValue = [[UILabel alloc]init];
        
        [cell.contentView addSubview:timeLabel];
        [cell.contentView addSubview:feetLabel];
        [cell.contentView addSubview:timeValue];
        [cell.contentView addSubview:feetValue];
    }
    timeLabel.frame = CGRectMake(20, 0, 50, 30);
    feetLabel.frame = CGRectMake(20, 30, 50, 30);
    timeValue.frame = CGRectMake(70, 0, cell.frame.size.width-50, 30);
    feetValue.frame = CGRectMake(70, 30, cell.frame.size.width-50, 30);
    
    NSDictionary *dict = nil;
    if(indexPath.section == 0){
        dict = lowTideArray[indexPath.row];
    } else {
        dict = highTideArray[indexPath.row];
    }
    feetLabel.text = @"Feet: ";
    timeLabel.text = @"Time: ";
    feetValue.text = dict[@"feet"];
    timeValue.text = dict[@"time"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *headingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    if(section == 0){
        headingLabel.text = @"Low Tides:";
    } else {
        headingLabel.text = @"High Tides:";
    }
    [headerView addSubview:headingLabel];
    return headerView;
}

- (void)httpGet:(NSString *)requestString {
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithRequest:req
               completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:nil];
         lowTideArray = jsonObject[@"Low"];
         highTideArray = jsonObject[@"High"];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [tideTableView reloadData];
         });
     }];
    [dataTask resume];
}

@end
