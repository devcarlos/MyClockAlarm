//
//  CoreDataHelper.h
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;

+(CoreDataHelper *) initCoreDataHelper;

-(void) initializeContext;
-(NSString *) getApplicationDocumentsDirectoryPath;
-(NSManagedObjectModel *) initilizeManagedObjectModel;
-(NSPersistentStoreCoordinator *) initilizeManagedPersistentStoreCoordinator;
-(void) saveCurrentContext;

//methods to perform database operations
-(void) insertAlarm :(NSString *)time Repeat:(NSString *)repeat;
-(void) selectAllAlarms;
-(NSManagedObject *) searchAlarmByTime :(NSString *) time;
-(void) deleteAlarmByTime:(NSString *) time;

@end
