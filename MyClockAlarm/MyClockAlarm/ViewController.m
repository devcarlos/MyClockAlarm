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
    
    [self performSelector:@selector(clockTime)];
    
    clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(clockTime)
                                                  userInfo:nil
                                                   repeats:YES];
    
}
- (void)clockTime
{
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTime = [dateFormatter stringFromDate: today];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //
        [self.clockLabel setFont:[UIFont fontWithName:@"DS-Digital" size:150.0]];
        
    }else{
        [self.clockLabel setFont:[UIFont fontWithName:@"DS-Digital" size:65.0]];
        
    }
    
    //Create a couple of colours for the background gradient
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.125 blue:0.18 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.00 blue:0.05 alpha:1.0];
    
    //Create the gradient and add it to our view's root layer
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(0.0, 0.0, 320.0, 480.0);
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil]];
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    //Set the label properties and glow params
    self.clockLabel.textColor = [UIColor colorWithRed:0.20 green:0.70 blue:1.0 alpha:1.0];
    self.clockLabel.glowColor = self.clockLabel.textColor;
    self.clockLabel.glowOffset = CGSizeMake(0.0, 0.0);
    self.clockLabel.glowAmount = 10.0;
    self.clockLabel.text = currentTime;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)showSettings:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"settings"];
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)showAlarms:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"alarms"];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
