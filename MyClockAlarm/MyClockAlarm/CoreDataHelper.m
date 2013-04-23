//
//  CoreDataHelper.m
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

@synthesize context;
@synthesize objectModel;
@synthesize coordinator;

#pragma mark - COREDATA -INITILIZE

static CoreDataHelper *coreDataHelper;

+(CoreDataHelper *) initCoreDataHelper{
    
    if (coreDataHelper == nil) {
        coreDataHelper = [[CoreDataHelper alloc] init];
        [coreDataHelper initializeContext];
    }
    return coreDataHelper;
}

#pragma mark - COREDATA -MANAGE LIFE CYCLE

//1. to get the dir path where we store our database file
-(NSString *) getApplicationDocumentsDirectoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

// 2. to manage object model
- (NSManagedObjectModel *) initilizeManagedObjectModel{
    if (objectModel != nil) {
        return objectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Alarms" withExtension:@"momd"];
    objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return objectModel;
}

// 3.to create core data
-(NSPersistentStoreCoordinator *) initilizeManagedPersistentStoreCoordinator{
    if (coordinator != nil) {
        return coordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self getApplicationDocumentsDirectoryPath]stringByAppendingPathComponent: @"Alarms.sqlite"]];
    NSError *error = nil;
    coordinator = [[NSPersistentStoreCoordinator alloc]
                   initWithManagedObjectModel:[self initilizeManagedObjectModel]];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return coordinator;
}

//4. to manage object context 
-(void) initializeContext{
    if (context == nil) {
        NSPersistentStoreCoordinator *acoordinator = [self initilizeManagedPersistentStoreCoordinator];
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:acoordinator];
    }
}

//5. to save context when app is going to be close/quit
-(void) saveCurrentContext{
    NSError *error = nil;
    if (context != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - COREDATA -INSERT


-(void) insertAlarm:(NSString *)time Repeat:(NSString *)repeat{
    
    NSManagedObject *newAlarm = [NSEntityDescription insertNewObjectForEntityForName:@"Alarms" inManagedObjectContext:context];
    [newAlarm setValue:time forKey:@"time"];
    [newAlarm setValue:repeat forKey:@"repeat"];
    
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"Alarm saved");
    }
    else{
        NSLog(@"Error occured while saving");
    }
}

#pragma mark - COREDATA -SELECT / VIEW ALL DATA


-(NSMutableArray *) selectAllAlarms{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alarms" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *alarms = nil;
    
    if ([objects count]>0) {
        alarms = [[NSMutableArray alloc] init];

        for (NSManagedObject *aAlarm in objects) {
            NSLog(@"time=%@, repeat=%@",[aAlarm valueForKey:@"time"],[aAlarm valueForKey:@"repeat"]);
            
            NSMutableDictionary *alarmDict = [NSMutableDictionary dictionary];
            [alarmDict setObject: [aAlarm valueForKey:@"time"] forKey: @"time"];
            [alarmDict setObject: [aAlarm valueForKey:@"repeat"] forKey: @"repeat"];
            
            [alarms addObject:alarmDict];
        }
        
    }
    else{
        NSLog(@"no matches found");
    }
    
    return alarms;
}


#pragma mark - COREDATA - SEARCH


//this method will returns an Object which contains one Alarm info details
-(NSManagedObject *) searchAlarmByTime:(NSString *)time{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alarms" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //add predicate to search by name
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time == %@",time];
    [fetchRequest setPredicate:predicate];
    NSManagedObject *aAlarm = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([objects count]==0) {
        NSLog(@"no matches found");
    }
    else{
        aAlarm = [objects objectAtIndex:0];
        NSLog(@"time=%@, repeat=%@",[aAlarm valueForKey:@"time"],[aAlarm valueForKey:@"repeat"]);
    }
    return aAlarm;
}

#pragma mark - COREDATA - DELETE


-(void) deleteAlarmByTime:(NSString *)time{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alarms" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time == %@", time];
    NSLog(@"my del predicate is :%@",predicate);
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] >0) {
        //delete object
        NSManagedObject *aAlarmObject= [fetchedObjects objectAtIndex:0];
        [context deleteObject:aAlarmObject];
        
        // Save everything after deletion
        if ([context save:&error]) {
            NSLog(@"The update was successful!");
        } else {
            NSLog(@"The update wasn't successful: %@", [error localizedDescription]);
        }
    }
    else{
        NSLog(@"no matches found");
    }
}



@end
