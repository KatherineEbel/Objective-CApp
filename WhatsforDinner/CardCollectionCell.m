//
//  CardCollectionCell.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "CardCollectionCell.h"

@implementation CardCollectionCell
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  CGPoint center = layoutAttributes.center;
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"position.y"];
  animation.toValue = @(center.y);
  animation.duration = 0.3;
  animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.8 :2.0 :1.0 :1.0];
  [super applyLayoutAttributes:layoutAttributes];
}
@end
