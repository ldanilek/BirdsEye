//
//  Storage.m
//  BirdsEye
//
//  Created by user120916 on 9/25/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "storage.h"

@interface Storage () <UITextFieldDelegate>

@end

@implementation Storage

// shared module for use in other classes
+ (Storage *)sharedModule {
    static Storage *module = nil;
    if (!module) {
        module = [[self alloc] init];
    }
    return module;
}

@end
