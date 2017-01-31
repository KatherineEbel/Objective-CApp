//
//  MealCategoriesViewModel.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MealCategory.h"

@interface MealCategoriesViewModel : NSObject
@property (strong, nonatomic) NSArray<MealCategory*> *categories;
@end
