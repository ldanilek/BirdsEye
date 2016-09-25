//
//  ViewController.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "ViewController.h"
#import "RequestModule.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // TODO: remove later
    RequestModule* sample = [RequestModule sharedModule];
    // testing
    [sample pingInfo:2 andGroupID:3];
    [sample joinGroupInfo:4 andTeam:6];
    [sample createGroupInfo:@"Shaneyney's Marauders" andTeams:10];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
