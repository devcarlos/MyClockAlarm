//
//  Alarms.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Alarms : NSManagedObject

@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * repeat;

@end
