//
//  TeamsTableViewController.m
//  BirdsEye
//
//  Created by Shanelle Roman on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "TeamsTableViewController.h"

@interface TeamsTableViewController ()

@property(nonatomic) NSMutableArray* numElem;

@end

@implementation TeamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //TODO: local array of the team names - dummy names for now
    //NSString *groupName = [_teamNames objectForKey:@"name"];
    NSDictionary *tempDict = _teamNames;
    NSNumber *teamNumbers = [tempDict objectForKey:@"num_teams"];
    NSMutableArray *numElem = [NSMutableArray array];
    NSString *str = @"Team ";
    for (int i = 0; i < [teamNumbers integerValue]; i++)
    {
        NSLog(@"enters the for loop");
        NSString *numstr = [NSString stringWithFormat:@"%i", i];
        //[numElem addObject:@"hello"];
        [numElem addObject: [str stringByAppendingString: numstr]];
    }

    
    self.numElem = numElem;

    

    
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

// assuming for now that we have team
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numElem.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"team-cell" forIndexPath:indexPath];
    cell.textLabel.text = self.numElem[indexPath.row];

    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
