//
//  RecipeCardCell.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 2/1/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "RecipeCardCell.h"

@implementation RecipeCardCell
- (void)setRecipe:(Recipe *)recipe {
  _recipe = recipe;
  self.recipeNameLabel.text = recipe.title;
  [self.recipeImageView setImageWithURL:recipe.imageURL];
  [self setNeedsLayout];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
