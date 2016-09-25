//
//  CustomAnnotationView.m
//  BirdsEye
//
//  Created by user120916 on 9/24/16.
//  Copyright © 2016 Shanelle's Marauders. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Mapbox;

@interface CustomAnnotationView : MGLAnnotationView
@end

@implementation CustomAnnotationView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Force the annotation view to maintain a constant size when the map is tilted.
    self.scalesWithViewingDistance = false;
    
    // Use CALayer’s corner radius to turn this view into a circle.
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 2;
    animation.fromValue = @1.0f;
    animation.toValue = @0.0f;
    [self.layer addAnimation:animation forKey:@"opacity"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Animate the border width in/out, creating an iris effect.
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animation.duration = 0.1;
    self.layer.borderWidth = selected ? self.frame.size.width / 4 : 2;
    [self.layer addAnimation:animation forKey:@"borderWidth"];
}

@end
