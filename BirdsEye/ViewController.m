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
    RequestModule* sample = [RequestModule sharedModule];
    [sample connectBackEnd: 1 andGroupID: 2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
