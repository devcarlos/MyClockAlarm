//
//  SettingsViewController.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>
- (void)settingsViewController:(SettingsViewController *)controller didFinishWithAlarmVibrate:(BOOL)av AlarmSound:(BOOL)as ShowDate:(BOOL)sd ShowWeekDay:(BOOL)swd Show24Hours:(BOOL)s24hours;
@end

@interface SettingsViewController : UITableViewController

- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *alarmVibrate;
@property (strong, nonatomic) IBOutlet UISwitch *alarmSound;
@property (strong, nonatomic) IBOutlet UISwitch *showDate;
@property (strong, nonatomic) IBOutlet UISwitch *showWeekDay;
@property (strong, nonatomic) IBOutlet UISwitch *show24hours;

@property (nonatomic, weak) id <SettingsViewControllerDelegate> delegate;

@end
