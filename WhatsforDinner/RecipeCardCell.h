//
//  RecipeCardCell.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 2/1/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "CardCollectionCell.h"
#import "Recipe.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface RecipeCardCell : CardCollectionCell
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) Recipe *recipe;
@end
