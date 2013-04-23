//
//  AlarmsViewController.m
//  MyClockAlarm
//
//  Created by Carlos Alcala on 4/22/13.
//  Copyright (c) 2013 Synapse Online SRL. All rights reserved.
//

#import "AlarmsViewController.h"
#import "CoreDataHelper.h"
#import "Alarms.h"

@interface AlarmsViewController ()

@end

@implementation AlarmsViewController

@synthesize alarms = _alarms;
@synthesize aAlarm;

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    NSMutableDictionary *hourDict = [NSMutableDictionary dictionary];
    
    [hourDict setObject: @"8:30" forKey: @"time"];
    [hourDict setObject: @"Weekdays" forKey: @"date"];
    
    [self.alarms addObject:hourDict];
    [self.alarms addObject:hourDict];
    [self.alarms addObject:hourDict];
     */
    
    self.alarms = [[CoreDataHelper initCoreDataHelper] selectAllAlarms];
    
    if (self.alarms == nil) {
        
    
        [[CoreDataHelper initCoreDataHelper] insertAlarm:@"8:30" Repeat:@"Weekdays"];
        [[CoreDataHelper initCoreDataHelper] insertAlarm:@"8:30" Repeat:@"Weekdays"];
        [[CoreDataHelper initCoreDataHelper] insertAlarm:@"8:30" Repeat:@"Weekdays"];
        [[CoreDataHelper initCoreDataHelper] insertAlarm:@"8:30" Repeat:@"Weekdays"];
        self.alarms = [[CoreDataHelper initCoreDataHelper] selectAllAlarms];
    
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.alarms count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlarmCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [[cell textLabel] setText:[[self.alarms objectAtIndex:indexPath.item] objectForKey:@"time"]];
    [[cell detailTextLabel] setText:[[self.alarms objectAtIndex:[indexPath row]] objectForKey:@"repeat"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
