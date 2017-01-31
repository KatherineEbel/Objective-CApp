//
//  MealCategoryCardCell.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/30/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "MealCategoryCardCell.h"

@implementation MealCategoryCardCell
- (void)awakeFromNib {
  [super awakeFromNib];
  self.layer.borderColor = [UIColor purpleColor].CGColor;
  self.layer.borderWidth = 2.0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
