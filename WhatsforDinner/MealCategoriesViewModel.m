//
//  MealCategoriesViewModel.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "MealCategoriesViewModel.h"

@implementation MealCategoriesViewModel
- (NSArray *)categories {
  if (!_categories) {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"MealCategories" ofType:@"plist"];
    _categories = [[NSArray alloc] initWithContentsOfFile: path ];
  }
  return _categories;
}
@end
