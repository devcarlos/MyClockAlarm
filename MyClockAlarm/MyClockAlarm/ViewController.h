//
//  ViewController.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/16/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UILabel *_clockLabel;
    NSTimer *clockTimer;
}

@property (strong, nonatomic) IBOutlet UILabel *clockLabel;


@end
