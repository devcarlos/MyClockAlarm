//
//  AlarmsViewController.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alarms;

@interface AlarmsViewController : UITableViewController {
    NSMutableArray *_alarms;
}

@property (nonatomic, strong) NSMutableArray *alarms;
@property (nonatomic, strong) Alarms  *aAlarm;

- (IBAction)back:(id)sender;

@end
