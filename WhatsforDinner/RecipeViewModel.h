//
//  RecipeViewModel.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "SpoonacularClient.h"
#import "RandomRecipeResponse.h"
#import <Overcoat/Overcoat.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MealCategory.h"

@interface RecipeViewModel : NSObject
@property (nonatomic, strong) NSArray<Recipe*> *randomRecipes;
@property (nonatomic, strong) NSArray<NSString*> *tags;
@property (nonatomic, strong) SpoonacularClient *client;
@property (nonatomic, strong) NSString *errorMessage;
- (instancetype)initWithRecipeTags:(NSArray<NSString*> *)tags;
@end
