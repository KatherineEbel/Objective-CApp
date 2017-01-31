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
    NSArray *categoriesDictArr = [[NSArray alloc] initWithContentsOfFile: path];
    _categories = [MealCategoriesViewModel categoriesFromArr:categoriesDictArr];
  }
  return _categories;
}
+ (NSArray<MealCategory*> *)categoriesFromArr:(NSArray<NSDictionary<NSString *, NSString *> *> *)arr {
  NSMutableArray *categories = [NSMutableArray new];
  for (NSDictionary *dict in arr) {
    MealCategory *category = [[MealCategory alloc] initWithDict:dict];
    [categories addObject: category];
  }
  return categories;
}
@end
