//
//  RecipeViewModel.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "RecipeViewModel.h"

@implementation RecipeViewModel
- (instancetype)initWithRecipeTags:(NSArray<NSString*> *)tags {
  _tags = tags;
  _client = [SpoonacularClient new];
  @weakify(self);
  [[[self.client getRandomRecipesWithTags: self.tags]
    take:1]
    subscribeNext:^(OVCResponse *response) {
      @strongify(self);
      RandomRecipeResponse *randResponse = response.result;
      self.randomRecipes = randResponse.recipes;
      NSLog(@"%@", self.randomRecipes);
    } error:^(NSError *error) {
      OVCResponse *response = error.userInfo[@"OVCResponse"];
      NSLog(@"%@", response.result);
      @strongify(self)
      self.errorMessage = response.result[@"message"];
    }];
  return self;
}
@end
