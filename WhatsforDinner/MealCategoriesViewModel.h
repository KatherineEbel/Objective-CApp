//
//  MealCategoriesViewModel.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MealCategory.h"
#import "SpoonacularClient.h"

@interface MealCategoriesViewModel : NSObject
@property (nonatomic, strong) SpoonacularClient *client;
@property (nonatomic, strong) NSMutableArray<NSString*> *selectedCategories;
@property (strong, nonatomic) NSArray<MealCategory*> *categories;
- (void)addToSelectedCategories:(NSString *)category;
@end
