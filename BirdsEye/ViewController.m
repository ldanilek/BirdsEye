//
//  ViewController.m
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import "ViewController.h"
#import "RequestModule.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UIButton *joinButton;
@property (nonatomic, weak) IBOutlet UIButton *createButton;

@property (nonatomic) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.joinButton.enabled = NO;
    self.createButton.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChanged:) name:UITextFieldTextDidChangeNotification object:self.nameField];

    RequestModule* sample = [RequestModule sharedModule];
    [sample connectBackEnd: 1 andGroupID: 2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)nameChanged:(NSNotification *)notification {
    self.name = self.nameField.text;
    self.joinButton.enabled = self.createButton.enabled = self.name.length > 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
