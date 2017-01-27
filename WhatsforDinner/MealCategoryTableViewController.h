//
//  MealCategoryTableViewController.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MealCategoriesViewModel.h"

@interface MealCategoryTableViewController : UITableViewController
@property (nonatomic, strong, readonly) MealCategoriesViewModel* viewModel;
@end
