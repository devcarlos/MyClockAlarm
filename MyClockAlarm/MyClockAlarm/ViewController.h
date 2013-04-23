//
//  ViewController.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/16/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRSGlowLabel.h"

@interface ViewController : UIViewController{
    RRSGlowLabel *_clockLabel;
    UILabel *_dateLabel;
    UILabel *_dayOfWeekLabel;
    UILabel *_ampmLabel;
    NSTimer *clockTimer;
}

@property (strong, nonatomic) IBOutlet RRSGlowLabel *clockLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayOfWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *ampmLabel;


- (IBAction)showSettings:(id)sender;

- (IBAction)showAlarms:(id)sender;
@end
