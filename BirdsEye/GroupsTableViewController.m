//
//  GroupsTableViewController.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "RequestModule.h"
#import "TeamsTableViewController.h"

@interface GroupsTableViewController ()

@property (nonatomic) NSArray *groupInfo;

@end

@implementation GroupsTableViewController

/*
-(NSArray *) getGroupInfo {
    return _groupInfo;
} */

- (void)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    
    [[RequestModule sharedModule] getGroupInfoReturningData:^(NSDictionary *dict){
       NSArray *nearbyGroups = dict[@"groups"];
        
        NSArray *fakeGroups = [NSArray arrayWithObjects:
        @{@"name": @"Team-Alex", @"group_id": @12, @"num_teams": @6},
        @{@"name": @"Team-Lee", @"group_id": @6, @"num_teams": @2}, nil
             ];
        
        self.groupInfo = nearbyGroups;
        [self.tableView reloadData];
        
    }];
    

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.groupInfo.count) {
        return self.groupInfo.count;
    } else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"group-cell" forIndexPath:indexPath];
    [cell setBackgroundColor: [UIColor blackColor]];
    [cell.textLabel setTextColor:[UIColor lightTextColor]];
     
    if (!indexPath.row && !self.groupInfo.count) {
        cell.textLabel.text = @"No groups available to join, try creating a group!";
        cell.userInteractionEnabled = NO;
    } else {
        cell.textLabel.text = self.groupInfo[indexPath.row][@"name"];
        cell.userInteractionEnabled = YES;
    }
       // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"to-team-list"])
    {

        // Get reference to the destination view controller
        TeamsTableViewController *vc = [segue destinationViewController];
        
        NSInteger index = [self.tableView indexPathForCell:sender].row;
        
        // Pass the teamNames info for the group that was clicked
        [vc setTeamNames: _groupInfo [index]];
    }
}


@end
