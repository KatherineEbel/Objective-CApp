//
//  CardCollectionCell.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "CardCollectionCell.h"

@implementation CardCollectionCell
- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.masksToBounds = NO;
  self.layer.shadowOpacity = 0.75;
  self.layer.shadowRadius = 2.0;
  self.layer.shadowOffset = CGSizeMake(0, 1);
  self.layer.shadowColor = [UIColor blackColor].CGColor;
//  self.layer.shadowPath = [UIBezierPath bezierPathWithRect: self.bounds].CGPath;
  self.clipsToBounds = YES;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes: layoutAttributes];
  CGPoint center = layoutAttributes.center;
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"position.y"];
  animation.toValue = @(center.y);
  animation.duration = 0.3;
  animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.8 :2.0 :1.0 :1.0];
  [self.layer addAnimation: animation forKey: @"position.y"];
  [super applyLayoutAttributes:layoutAttributes];
}
@end
