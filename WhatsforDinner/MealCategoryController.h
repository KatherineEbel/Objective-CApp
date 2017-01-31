//
//  MealCategoryController.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/30/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCollectionViewLayout.h"
#import "CardStackCollectionViewDelegate.h"
#import "MealCategoriesViewModel.h"
#import "MealCategoryCardCell.h"
@interface MealCategoryController : UICollectionViewController <CardStackCollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) int numberOfCards;
@property (nonatomic, strong, readonly) MealCategoriesViewModel* viewModel;
@end
