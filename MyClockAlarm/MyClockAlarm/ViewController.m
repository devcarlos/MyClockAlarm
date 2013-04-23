//
//  ViewController.m
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/16/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize clockLabel = _clockLabel;
@synthesize dateLabel = _dateLabel;
@synthesize dayOfWeekLabel = _dayOfWeekLabel;
@synthesize ampmLabel = _ampmLabel;

@synthesize alarmSound = _alarmSound;
@synthesize alarmVibrate = _alarmVibrate;
@synthesize showDate = _showDate;
@synthesize showWeekDay = _showWeekDay;
@synthesize show24hours = _show24hours;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
    // array
    NSMutableArray *fontNames = [[NSMutableArray alloc] init];
    
    // get font family
    NSArray *fontFamilyNames = [UIFont familyNames];
    
    // loop
    for (NSString *familyName in fontFamilyNames)
    {
        NSLog(@"Font Family Name = %@", familyName);
        
        // font names under family
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        
        NSLog(@"Font Names = %@", fontNames);
        
        // add to array
        [fontNames addObjectsFromArray:names];
    }
    */
    
    //activate settings
    self.alarmVibrate = YES;
    self.alarmSound = YES;
    self.show24hours = YES;
    self.showDate = YES;
    self.showWeekDay = YES;
    
    [self performSelector:@selector(clockTime)];
    
    clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(clockTime)
                                                  userInfo:nil
                                                   repeats:YES];
    
}
- (void)settingsViewController:(SettingsViewController *)controller didFinishWithAlarmVibrate:(BOOL)av AlarmSound:(BOOL)as ShowDate:(BOOL)sd ShowWeekDay:(BOOL)swd Show24Hours:(BOOL)s24hours
{
    self.alarmVibrate = av;
    self.alarmSound = as;
    self.show24hours = s24hours;
    self.showDate = sd;
    self.showWeekDay = swd;
    
    [self.view setNeedsDisplay];    
}

- (void)clockTime
{
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTime = [dateFormatter stringFromDate: today];

    [dateFormatter setDateFormat:@"MMMM dd YYYY"];
    NSString *currentDate = [dateFormatter stringFromDate: today];

    [dateFormatter setDateFormat:@"EEEE"];
    NSString *currentDayOfWeek = [dateFormatter stringFromDate: today];
    
    [dateFormatter setDateFormat:@"a"];
    NSString *currentPeriod = [dateFormatter stringFromDate: today];
    
    
    //Create a couple of colours for the background gradient
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.125 blue:0.18 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.00 blue:0.05 alpha:1.0];
    
    //Create the gradient and add it to our view's root layer
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //
        [self.clockLabel setFont:[UIFont fontWithName:@"DS-Digital" size:180.0]];
        [self.dateLabel setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [self.dayOfWeekLabel setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [self.ampmLabel setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        gradientLayer.frame = CGRectMake(0.0, 0.0, 768.0, 1004.0);
        
    }else{
        [self.clockLabel setFont:[UIFont fontWithName:@"DS-Digital" size:85.0]];
        [self.dateLabel setFont:[UIFont fontWithName:@"DS-Digital" size:16.0]];
        [self.dayOfWeekLabel setFont:[UIFont fontWithName:@"DS-Digital" size:16.0]];
        [self.ampmLabel setFont:[UIFont fontWithName:@"DS-Digital" size:16.0]];
        gradientLayer.frame = CGRectMake(0.0, 0.0, 320.0, 480.0);
        
    }

    [gradientLayer setColors:[NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil]];
    [self.view.layer insertSublayer:gradientLayer atIndex:0];

    
    //Set the label properties and glow params
    self.clockLabel.textColor = [UIColor colorWithRed:0.20 green:0.70 blue:1.0 alpha:1.0];
    self.clockLabel.glowColor = self.clockLabel.textColor;
    self.clockLabel.glowOffset = CGSizeMake(0.0, 0.0);
    self.clockLabel.glowAmount = 35.0;
    self.clockLabel.text = currentTime;
    
    //check to change only if the text has changed
    if (![self.dateLabel.text isEqualToString:currentDate]) {
        self.dateLabel.text = currentDate;
    }

    //check to change only if the text has changed
    if (![self.dayOfWeekLabel.text isEqualToString:currentDayOfWeek]) {
        self.dayOfWeekLabel.text = currentDayOfWeek;
    }
    
    //check to change only if the text has changed
    if (![self.ampmLabel.text isEqualToString:currentPeriod]) {
        self.ampmLabel.text = currentPeriod;
    }
    
    if (self.showDate == NO) {
        self.dateLabel.hidden = YES;
    } else {
        self.dateLabel.hidden = NO;
    }
    
    
    if (self.showWeekDay == NO) {
        self.dayOfWeekLabel.hidden = YES;
    } else {
        self.dayOfWeekLabel.hidden = NO;
    }
    
    if (self.show24hours == NO) {
        self.clockLabel.hidden = YES;
        self.ampmLabel.hidden = YES;
    } else {
        self.clockLabel.hidden = NO;
        self.ampmLabel.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)showSettings:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    SettingsViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"settings"];
    //SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    controller.delegate = self;
    //[[self navigationController] pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)showAlarms:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"alarms"];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
