//
//  MapViewController.h
//  BirdsEye
//
//  Created by Lee on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController

+(MapViewController*)sharedModule;

//important info storage, maybe shouldnt go here?
@property int groupId;
@property int teamId;
@property int userId;

@end

